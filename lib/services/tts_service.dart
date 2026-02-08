import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();
  
  Future<void> initialize() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text, {double? speed}) async {
    if (speed != null) {
      await _flutterTts.setSpeechRate(speed);
    }
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  Future<void> setSpeed(double speed) async {
    await _flutterTts.setSpeechRate(speed);
  }

  void dispose() {
    _flutterTts.stop();
  }
}

// Global instance
final ttsService = TTSService();
