import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../providers/role_provider.dart';

/// 👥 Role Selection - Choose Child, Parent, or Teacher
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundLight,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // 🔙 Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(13),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: AppColors.textDark),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // 🐣 Mascot
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.warmGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentPeach.withAlpha(102),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('🤗', style: TextStyle(fontSize: 44)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Who\'s using the app today?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // 🎴 Role Cards
                _RoleCard(
                  emoji: '🧒',
                  title: 'I\'m a Child',
                  subtitle: 'Play games & learn emotions!',
                  gradient: AppColors.warmGradient,
                  onTap: () {
                    context.read<RoleProvider>().setRole('child');
                    Navigator.pushReplacementNamed(context, '/child-dashboard');
                  },
                ),
                
                const SizedBox(height: 16),
                
                _RoleCard(
                  emoji: '👨‍👩‍👧',
                  title: 'I\'m a Parent',
                  subtitle: 'Track progress & get tips',
                  gradient: AppColors.mintGradient,
                  onTap: () {
                    context.read<RoleProvider>().setRole('parent');
                    Navigator.pushReplacementNamed(context, '/parent-dashboard');
                  },
                ),
                
                const SizedBox(height: 16),
                
                _RoleCard(
                  emoji: '👩‍🏫',
                  title: 'I\'m a Teacher',
                  subtitle: 'Manage & monitor students',
                  gradient: AppColors.primaryGradient,
                  onTap: () {
                    context.read<RoleProvider>().setRole('teacher');
                    Navigator.pushReplacementNamed(context, '/teacher-dashboard');
                  },
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

class _RoleCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;
  
  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withAlpha(102),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(64),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withAlpha(204),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
