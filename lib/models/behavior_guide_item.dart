class BehaviorGuideItem {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final List<String> reasons;
  final List<String> doResponses;
  final List<String> dontResponses;
  final List<String> calmingTips;
  final String category; // 'communication', 'sensory', 'emotional', 'social'

  BehaviorGuideItem({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.reasons,
    required this.doResponses,
    required this.dontResponses,
    required this.calmingTips,
    required this.category,
  });

  factory BehaviorGuideItem.fromMap(Map<String, dynamic> map) {
    return BehaviorGuideItem(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      description: map['description'],
      reasons: List<String>.from(map['reasons']),
      doResponses: List<String>.from(map['doResponses']),
      dontResponses: List<String>.from(map['dontResponses']),
      calmingTips: List<String>.from(map['calmingTips']),
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'description': description,
      'reasons': reasons,
      'doResponses': doResponses,
      'dontResponses': dontResponses,
      'calmingTips': calmingTips,
      'category': category,
    };
  }
}
