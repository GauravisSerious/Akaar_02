import 'package:flutter/foundation.dart';
import '../models/emotion_result.dart';

class EmotionHistoryProvider with ChangeNotifier {
  List<EmotionResult> _history = [];

  List<EmotionResult> get history => List.unmodifiable(_history);

  List<EmotionResult> get recentHistory {
    final sorted = List<EmotionResult>.from(_history)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(10).toList();
  }

  void addResult(EmotionResult result) {
    _history.add(result);
    notifyListeners();
  }

  void loadHistory(List<EmotionResult> results) {
    _history = results;
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  // Get history for a specific date range
  List<EmotionResult> getHistoryForDateRange(DateTime start, DateTime end) {
    return _history
        .where((result) =>
            result.timestamp.isAfter(start) &&
            result.timestamp.isBefore(end))
        .toList();
  }

  // Get emotion distribution
  Map<String, int> getEmotionDistribution() {
    final distribution = <String, int>{};
    for (final result in _history) {
      distribution[result.emotion] = (distribution[result.emotion] ?? 0) + 1;
    }
    return distribution;
  }

  // Get emotion distribution for date range
  Map<String, int> getEmotionDistributionForDateRange(
      DateTime start, DateTime end) {
    final rangeResults = getHistoryForDateRange(start, end);
    final distribution = <String, int>{};
    for (final result in rangeResults) {
      distribution[result.emotion] = (distribution[result.emotion] ?? 0) + 1;
    }
    return distribution;
  }
}
