import 'dart:io';
import 'dart:math' as math;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../shared/emotions.dart';

class MLService {
  Interpreter? _faceInterpreter;
  Interpreter? _voiceInterpreter;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Load face model (CNN)
      _faceInterpreter = await Interpreter.fromAsset('assets/models/cnn_model.tflite');
      print('✅ Face model loaded');
    } catch (e) {
      print('⚠️ Face model not found: $e');
    }

    try {
      // Load voice model (LSTM)
      _voiceInterpreter = await Interpreter.fromAsset('assets/models/lstm_model.tflite');
      print('✅ Voice model loaded');
    } catch (e) {
      print('⚠️ Voice model not found: $e');
    }

    _isInitialized = true;
  }

  Future<Map<String, double>> predictFace(String imagePath) async {
    if (_faceInterpreter == null) {
      print('⚠️ Face model not loaded, using mock');
      return Emotions.mockProbs(seed: Emotions.seedFromString(imagePath));
    }

    try {
      // Preprocess image: 48x48 grayscale, normalized 0-1
      final input = await _preprocessImage(imagePath);
      
      // Output shape: [1, 7] for 7 emotions
      var output = List.generate(1, (_) => List.filled(7, 0.0));
      
      _faceInterpreter!.run(input, output);
      
      // Convert to probabilities map
      final probs = <String, double>{};
      for (int i = 0; i < Emotions.labels.length; i++) {
        probs[Emotions.labels[i]] = output[0][i];
      }
      
      return _softmax(probs);
    } catch (e) {
      print('❌ Face prediction error: $e');
      return Emotions.mockProbs(seed: Emotions.seedFromString(imagePath));
    }
  }

  Future<Map<String, double>> predictVoice(String audioPath) async {
    if (_voiceInterpreter == null) {
      print('⚠️ Voice model not loaded, using mock');
      return Emotions.mockProbs(seed: Emotions.seedFromString(audioPath));
    }

    try {
      // TODO: Implement audio preprocessing (MFCC extraction)
      // For now, fall back to mock
      print('⚠️ Audio preprocessing not implemented yet, using mock');
      return Emotions.mockProbs(seed: Emotions.seedFromString(audioPath));
    } catch (e) {
      print('❌ Voice prediction error: $e');
      return Emotions.mockProbs(seed: Emotions.seedFromString(audioPath));
    }
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(String path) async {
    // Read image
    final bytes = await File(path).readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    
    if (image == null) throw Exception('Failed to decode image');
    
    // Resize to 48x48
    image = img.copyResize(image, width: 48, height: 48);
    
    // Convert to grayscale and normalize
    final input = List.generate(
      1,
      (_) => List.generate(
        48,
        (y) => List.generate(
          48,
          (x) {
            final pixel = image!.getPixel(x, y);
            // Convert to grayscale: 0.299*R + 0.587*G + 0.114*B
            final gray = (0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b) / 255.0;
            return [gray];
          },
        ),
      ),
    );
    
    return input;
  }

  Map<String, double> _softmax(Map<String, double> logits) {
    final values = logits.values.toList();
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    
    // Subtract max for numerical stability
    final expValues = values.map((v) => exp(v - maxVal)).toList();
    final sumExp = expValues.reduce((a, b) => a + b);
    
    final result = <String, double>{};
    int i = 0;
    for (final label in logits.keys) {
      result[label] = expValues[i] / sumExp;
      i++;
    }
    
    return result;
  }

  double exp(double x) {
    return math.exp(x);
  }

  void dispose() {
    _faceInterpreter?.close();
    _voiceInterpreter?.close();
    _isInitialized = false;
  }
}
