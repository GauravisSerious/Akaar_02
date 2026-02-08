import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math';
import '../../shared/emotions.dart';
import '../../providers/game_provider.dart';
import '../../models/game_score.dart';
import 'package:uuid/uuid.dart';

class FaceEmotionGame extends StatefulWidget {
  const FaceEmotionGame({super.key});

  @override
  State<FaceEmotionGame> createState() => _FaceEmotionGameState();
}

class _FaceEmotionGameState extends State<FaceEmotionGame> {
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  final int _totalQuestions = 5;
  String? _selectedAnswer;
  bool _answered = false;
  String _currentEmotion = '';
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    _currentEmotion = Emotions.labels[random.nextInt(Emotions.labels.length)];
    
    // Generate 4 options including correct answer
    _options = [_currentEmotion];
    while (_options.length < 4) {
      final option = Emotions.labels[random.nextInt(Emotions.labels.length)];
      if (!_options.contains(option)) {
        _options.add(option);
      }
    }
    _options.shuffle();
  }

  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _currentEmotion) {
        _correctAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (_currentQuestion + 1 < _totalQuestions) {
          setState(() {
            _currentQuestion++;
            _answered = false;
            _selectedAnswer = null;
            _generateQuestion();
          });
        } else {
          _showResults();
        }
      }
    });
  }

  void _showResults() {
    final gameProvider = context.read<GameProvider>();
    final xpEarned = _correctAnswers * 20;
    final score = GameScore(
      id: const Uuid().v4(),
      gameType: 'face_emotion',
      score: _correctAnswers * 100,
      totalQuestions: _totalQuestions,
      correctAnswers: _correctAnswers,
      xpEarned: xpEarned,
      timestamp: DateTime.now(),
      difficulty: 'easy',
    );
    
    gameProvider.addScore(score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Text(
              _correctAnswers >= 4 ? '🎉' : _correctAnswers >= 2 ? '👍' : '💪',
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 16),
            Text(
              _correctAnswers >= 4 ? 'Amazing!' : _correctAnswers >= 2 ? 'Good Job!' : 'Keep Trying!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C4DFF),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You got $_correctAnswers out of $_totalQuestions correct!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEB3B).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('⭐', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    '+$xpEarned XP',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9800),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back to Menu'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestion = 0;
                _correctAnswers = 0;
                _answered = false;
                _selectedAnswer = null;
                _generateQuestion();
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Emotion Game'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${_currentQuestion + 1}/$_totalQuestions',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress bar
              FadeInDown(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_currentQuestion + 1) / _totalQuestions,
                    minHeight: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Question
              FadeIn(
                child: const Text(
                  'Which emotion is this?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Emoji
              ZoomIn(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C4DFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      Emotions.getEmoji(_currentEmotion),
                      style: const TextStyle(fontSize: 120),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Options
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: _options.map((option) {
                    final isCorrect = option == _currentEmotion;
                    final isSelected = option == _selectedAnswer;
                    
                    Color getColor() {
                      if (!_answered) return const Color(0xFF7C4DFF);
                      if (isSelected && isCorrect) return const Color(0xFF4CAF50);
                      if (isSelected && !isCorrect) return const Color(0xFFF44336);
                      if (isCorrect) return const Color(0xFF4CAF50);
                      return Colors.grey;
                    }

                    return BounceInUp(
                      delay: Duration(milliseconds: 100 * _options.indexOf(option)),
                      child: ElevatedButton(
                        onPressed: _answered ? null : () => _checkAnswer(option),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
