import 'package:hive/hive.dart';

part 'emotion_result.g.dart';

@HiveType(typeId: 0)
class EmotionResult {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String emotion;

  @HiveField(2)
  final double confidence;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String? imagePath;

  @HiveField(5)
  final String? audioPath;

  @HiveField(6)
  final String detectionType; // 'face', 'voice', 'combined'

  @HiveField(7)
  final Map<String, double> allProbabilities;

  EmotionResult({
    required this.id,
    required this.emotion,
    required this.confidence,
    required this.timestamp,
    this.imagePath,
    this.audioPath,
    required this.detectionType,
    required this.allProbabilities,
  });

  factory EmotionResult.fromMap(Map<String, dynamic> map) {
    return EmotionResult(
      id: map['id'],
      emotion: map['emotion'],
      confidence: map['confidence'],
      timestamp: DateTime.parse(map['timestamp']),
      imagePath: map['imagePath'],
      audioPath: map['audioPath'],
      detectionType: map['detectionType'],
      allProbabilities: Map<String, double>.from(map['allProbabilities']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotion': emotion,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
      'imagePath': imagePath,
      'audioPath': audioPath,
      'detectionType': detectionType,
      'allProbabilities': allProbabilities,
    };
  }
}
