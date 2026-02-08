import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

/// Emotion Buddy - The cute mascot companion
/// Appears throughout the app to encourage and guide kids
class EmotionBuddy extends StatelessWidget {
  final String emotion;
  final String? message;
  final double size;
  
  const EmotionBuddy({
    super.key,
    this.emotion = 'happy',
    this.message,
    this.size = 80,
  });
  
  String get _getEmoji {
    switch (emotion.toLowerCase()) {
      case 'happy':
      case 'joy':
        return '😊';
      case 'excited':
        return '🤩';
      case 'calm':
      case 'relaxed':
        return '😌';
      case 'thinking':
        return '🤔';
      case 'celebrating':
        return '🎉';
      case 'encouraging':
        return '🌟';
      case 'sad':
        return '😢';
      case 'angry':
        return '😠';
      case 'surprised':
        return '😲';
      case 'meditation':
        return '🧘';
      default:
        return '😊';
    }
  }
  
  Color get _getBubbleColor {
    switch (emotion.toLowerCase()) {
      case 'happy':
      case 'excited':
      case 'celebrating':
        return const Color(0xFFFFE66D);
      case 'calm':
      case 'meditation':
        return const Color(0xFF88DEB8);
      case 'encouraging':
        return const Color(0xFF8B7FD6);
      case 'sad':
        return const Color(0xFF6EC8E8);
      default:
        return const Color(0xFFFFB4A2);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mascot emoji with bounce animation
        Bounce(
          infinite: true,
          duration: const Duration(seconds: 2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getBubbleColor.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: _getBubbleColor.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                _getEmoji,
                style: TextStyle(fontSize: size * 0.6),
              ),
            ),
          ),
        ),
        
        // Message bubble if provided
        if (message != null) ...[
          const SizedBox(height: 16),
          FadeIn(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Mini Emotion Buddy for smaller spaces
class MiniEmotionBuddy extends StatelessWidget {
  final String emotion;
  
  const MiniEmotionBuddy({
    super.key,
    this.emotion = 'happy',
  });
  
  @override
  Widget build(BuildContext context) {
    return EmotionBuddy(
      emotion: emotion,
      size: 40,
    );
  }
}
