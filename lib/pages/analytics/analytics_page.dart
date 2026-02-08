import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/emotion_history_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionHistory = context.watch<EmotionHistoryProvider>();
    final distribution = emotionHistory.getEmotionDistribution();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Emotion Distribution',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            if (distribution.isEmpty)
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text('📊', style: TextStyle(fontSize: 60)),
                    const SizedBox(height: 16),
                    Text(
                      'No data yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start detecting emotions to see analytics',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: [
                  // Pie chart
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: _generatePieChartSections(distribution),
                        centerSpaceRadius: 50,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Legend
                  ...distribution.entries.map((entry) {
                    final color = _getColorForEmotion(entry.key);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            '${entry.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),

            const SizedBox(height: 40),

            // Recent history
            const Text(
              'Recent Detections',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ...emotionHistory.recentHistory.map((result) {
              return Card(
                child: ListTile(
                  leading: Text(
                    _getEmojiForEmotion(result.emotion),
                    style: const TextStyle(fontSize: 32),
                  ),
                  title: Text(
                    result.emotion,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${(result.confidence * 100).toStringAsFixed(1)}% confidence',
                  ),
                  trailing: Text(
                    _formatDate(result.timestamp),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(Map<String, int> distribution) {
    final total = distribution.values.reduce((a, b) => a + b);
    
    return distribution.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${percentage.toStringAsFixed(0)}%',
        color: _getColorForEmotion(entry.key),
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getColorForEmotion(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'happy':
        return const Color(0xFFFFEB3B);
      case 'sad':
        return const Color(0xFF2196F3);
      case 'angry':
        return const Color(0xFFF44336);
      case 'surprise':
        return const Color(0xFFFF9800);
      case 'fear':
        return const Color(0xFF9C27B0);
      case 'disgust':
        return const Color(0xFF4CAF50);
      case 'neutral':
        return const Color(0xFF9E9E9E);
      default:
        return const Color(0xFF7C4DFF);
    }
  }

  String _getEmojiForEmotion(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'angry':
        return '😠';
      case 'surprise':
        return '😲';
      case 'fear':
        return '😨';
      case 'disgust':
        return '🤢';
      case 'neutral':
        return '😐';
      default:
        return '😊';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}
