import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/kid_widgets.dart';

/// 🏠 Home Page - Beautiful welcome screen with mascot
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // 🐣 Welcome Mascot
                const EmotionBuddy(
                  emotion: 'wave',
                  message: 'Hi friend! Ready to explore emotions? 🌈',
                  size: 100,
                ),
                
                const SizedBox(height: 32),
                
                // 📛 App Title
                const Text(
                  'A.A.K.A.R',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'AI Assistive Kit for Autism',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // 📋 Welcome Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '🎮 Let\'s Learn Emotions!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Play games, detect feelings, and have fun learning about emotions!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // 🔘 Main Buttons
                PremiumButton(
                  label: 'Choose Dashboard',
                  iconData: Icons.dashboard_rounded,
                  onPressed: () => Navigator.pushNamed(context, '/role-selection'),
                  gradient: AppColors.warmGradient,
                ),
                
                const SizedBox(height: 16),
                
                Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/detect'),
                    icon: const Icon(Icons.face, size: 26, color: AppColors.primaryPurple),
                    label: const Text(
                      'Detect Emotion',
                      style: TextStyle(fontSize: 18, color: AppColors.primaryPurple),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // 🎯 Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _QuickAction(
                      emoji: '🎮',
                      label: 'Games',
                      onTap: () => Navigator.pushNamed(context, '/game-menu'),
                    ),
                    _QuickAction(
                      emoji: '😌',
                      label: 'Calm',
                      onTap: () => Navigator.pushNamed(context, '/calm-mode'),
                    ),
                    _QuickAction(
                      emoji: '💬',
                      label: 'Chat',
                      onTap: () => Navigator.pushNamed(context, '/chatbot'),
                    ),
                    _QuickAction(
                      emoji: '📊',
                      label: 'Stats',
                      onTap: () => Navigator.pushNamed(context, '/analytics'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;
  
  const _QuickAction({
    required this.emoji,
    required this.label,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withAlpha(77), width: 2),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
