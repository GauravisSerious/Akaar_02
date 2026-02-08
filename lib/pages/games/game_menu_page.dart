import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class GameMenuPage extends StatelessWidget {
  const GameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play & Learn'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: const Text(
                  'Choose a Game 🎮',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C4DFF),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Learn emotions while having fun!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    FadeInLeft(
                      delay: const Duration(milliseconds: 200),
                      child: _buildGameCard(
                        context,
                        emoji: '😊',
                        title: 'Face Emotion Game',
                        description: 'Guess the emotion from faces',
                        color: const Color(0xFF4CAF50),
                        route: '/face-game',
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInRight(
                      delay: const Duration(milliseconds: 300),
                      child: _buildGameCard(
                        context,
                        emoji: '🎤',
                        title: 'Voice Emotion Game',
                        description: 'Guess emotions from voice',
                        color: const Color(0xFFFF9800),
                        route: '/face-game', // Placeholder
                        isComingSoon: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 400),
                      child: _buildGameCard(
                        context,
                        emoji: '🏆',
                        title: 'My Rewards',
                        description: 'View your badges and achievements',
                        color: const Color(0xFFFFEB3B),
                        route: '/rewards',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required String description,
    required Color color,
    required String route,
    bool isComingSoon = false,
  }) {
    return InkWell(
      onTap: isComingSoon
          ? null
          : () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: color,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isComingSoon ? '🔜 Coming Soon!' : description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontStyle: isComingSoon ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (!isComingSoon)
              Icon(Icons.arrow_forward_ios, color: color, size: 24),
          ],
        ),
      ),
    );
  }
}
