import 'package:hive/hive.dart';

part 'game_score.g.dart';

@HiveType(typeId: 1)
class GameScore {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String gameType; // 'face_emotion', 'voice_emotion'

  @HiveField(2)
  final int score;

  @HiveField(3)
  final int totalQuestions;

  @HiveField(4)
  final int correctAnswers;

  @HiveField(5)
  final int xpEarned;

  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final String difficulty; // 'easy', 'medium', 'hard'

  GameScore({
    required this.id,
    required this.gameType,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.xpEarned,
    required this.timestamp,
    required this.difficulty,
  });

  double get accuracy => totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  factory GameScore.fromMap(Map<String, dynamic> map) {
    return GameScore(
      id: map['id'],
      gameType: map['gameType'],
      score: map['score'],
      totalQuestions: map['totalQuestions'],
      correctAnswers: map['correctAnswers'],
      xpEarned: map['xpEarned'],
      timestamp: DateTime.parse(map['timestamp']),
      difficulty: map['difficulty'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameType': gameType,
      'score': score,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'xpEarned': xpEarned,
      'timestamp': timestamp.toIso8601String(),
      'difficulty': difficulty,
    };
  }
}

@HiveType(typeId: 2)
class Badge {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String emoji;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime unlockedAt;

  Badge({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.unlockedAt,
  });
}
