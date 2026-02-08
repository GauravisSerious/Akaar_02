import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';
import '../../providers/game_provider.dart';
import '../../widgets/kid_widgets.dart';

/// 🧒 Child Dashboard - Game Hub with XP and fun activities
class ChildDashboard extends StatelessWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Scaffold(
      body: Container(
        color: AppColors.backgroundLight,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👋 Header with greeting
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
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
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi there! 👋',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Text(
                            'Ready to play?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppColors.warmGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text('🔥', style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // ⭐ XP Progress
                XPProgressBar(
                  currentXP: gameProvider.totalXP,
                  maxXP: gameProvider.xpForNextLevel,
                  level: gameProvider.level,
                ),
                
                const SizedBox(height: 24),
                
                // 🎮 Main Activity Cards
                const Text(
                  'What do you want to do?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Activity Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                  children: [
                    _ActivityCard(
                      emoji: '🎮',
                      title: 'Games',
                      color: AppColors.accentYellow,
                      onTap: () => Navigator.pushNamed(context, '/game-menu'),
                    ),
                    _ActivityCard(
                      emoji: '📷',
                      title: 'Detect',
                      color: AppColors.primaryBlue,
                      onTap: () => Navigator.pushNamed(context, '/detect'),
                    ),
                    _ActivityCard(
                      emoji: '💬',
                      title: 'Chat',
                      color: AppColors.accentMint,
                      onTap: () => Navigator.pushNamed(context, '/chatbot'),
                    ),
                    _ActivityCard(
                      emoji: '😌',
                      title: 'Calm',
                      color: AppColors.accentPeach,
                      onTap: () => Navigator.pushNamed(context, '/calm-mode'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 🏆 Recent Badges
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(13),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '🏆 My Badges',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/rewards'),
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: gameProvider.badges.length > 5 ? 5 : gameProvider.badges.length,
                          itemBuilder: (context, index) {
                            final badge = gameProvider.badges[index];
                            return Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                gradient: AppColors.mintGradient,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(badge.emoji, style: const TextStyle(fontSize: 28)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100), // Bottom padding for nav
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String emoji;
  final String title;
  final Color color;
  final VoidCallback onTap;
  
  const _ActivityCard({
    required this.emoji,
    required this.title,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(38),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withAlpha(77), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withAlpha(51),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
