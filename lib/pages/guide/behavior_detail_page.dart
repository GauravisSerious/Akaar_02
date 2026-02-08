import 'package:flutter/material.dart';
import '../../models/behavior_guide_item.dart';

class BehaviorDetailPage extends StatelessWidget {
  final BehaviorGuideItem guide;

  const BehaviorDetailPage({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(guide.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and title
            Center(
              child: Column(
                children: [
                  Text(guide.emoji, style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  Text(
                    guide.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C4DFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    guide.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Why this happens
            _buildSection(
              title: '💭 Why This Happens',
              color: const Color(0xFF00BCD4),
              items: guide.reasons,
            ),
            const SizedBox(height: 24),

            // Do's
            _buildSection(
              title: '✅ What TO Do',
              color: const Color(0xFF4CAF50),
              items: guide.doResponses,
            ),
            const SizedBox(height: 24),

            // Don'ts
            _buildSection(
              title: '❌ What NOT To Do',
              color: const Color(0xFFF44336),
              items: guide.dontResponses,
            ),
            const SizedBox(height: 24),

            // Calming tips
            _buildSection(
              title: '😌 Calming Tips',
              color: const Color(0xFFFF9800),
              items: guide.calmingTips,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
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
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
