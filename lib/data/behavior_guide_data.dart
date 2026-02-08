import '../../models/behavior_guide_item.dart';

class BehaviorGuideData {
  static final List<BehaviorGuideItem> guides = [
    BehaviorGuideItem(
      id: '1',
      title: 'Avoiding Eye Contact',
      emoji: '👀',
      description: 'Child may look away or avoid looking directly at faces',
      reasons: [
        'Direct gaze can feel overwhelming or uncomfortable',
        'Processing information is easier without eye contact',
        'Cultural or personal comfort preferences',
        'Sensory sensitivities',
      ],
      doResponses: [
        'Accept side-by-side positioning',
        'Allow the child to look at something else while talking',
        'Don\'t force eye contact',
        'Respect their comfort zone',
        'Use their name to get attention instead',
      ],
      dontResponses: [
        'Demand eye contact',
        'Say "look at me" repeatedly',
        'Assume they\'re not listening',
        'Make them feel ashamed',
      ],
      calmingTips: [
        'Create a predictable environment',
        'Use gentle, calm voice',
        'Give processing time',
      ],
      category: 'communication',
    ),
    BehaviorGuideItem(
      id: '2',
      title: 'Hand Flapping / Stimming',
      emoji: '👐',
      description: 'Repetitive hand movements or body rocking',
      reasons: [
        'Self-soothing and emotional regulation',
        'Expression of excitement or happiness',
        'Sensory seeking behavior',
        'Coping with overwhelming situations',
      ],
      doResponses: [
        'Allow the behavior - it\'s not harmful',
        'Understand it helps them regulate',
        'Join in if they seem comfortable',
        'Provide alternative stim toys if needed',
      ],
      dontResponses: [
        'Try to stop it',
        'Say "stop doing that"',
        'Make them feel embarrassed',
        'Restrain their hands',
      ],
      calmingTips: [
        'Provide sensory toys',
        'Create a safe space for stimming',
        'Reduce sensory overload',
      ],
      category: 'sensory',
    ),
    BehaviorGuideItem(
      id: '3',
      title: 'Silent / Non-verbal',
      emoji: '🤐',
      description: 'Child is quiet or not speaking',
      reasons: [
        'May be feeling overwhelmed',
        'Processing emotions internally',
        'Communication difficulties',
        'Feeling sad or anxious',
      ],
      doResponses: [
        'Give them space and time',
        'Offer comfort items',
        'Use calm, gentle voice',
        'Provide alternative communication methods (pictures, writing)',
        'Let them know you\'re available when ready',
      ],
      dontResponses: [
        'Force them to talk',
        'Get frustrated',
        'Keep asking "what\'s wrong?"',
        'Assume the worst',
      ],
      calmingTips: [
        'Quiet, safe space',
        'Dim lighting',
        'Comfort objects',
        'Patient presence',
      ],
      category: 'emotional',
    ),
    BehaviorGuideItem(
      id: '4',
      title: 'Meltdowns / Screaming',
      emoji: '😫',
      description: 'Intense emotional outbursts or crying',
      reasons: [
        'Sensory overload',
        'Emotional overwhelm',
        'Communication frustration',
        'Change in routine',
        'Physical discomfort',
      ],
      doResponses: [
        'Stay calm yourself',
        'Reduce sensory input (lights, noise)',
        'Give space if safe',
        'Use simple, calm language',
        'Wait it out patiently',
        'Ensure physical safety',
      ],
      dontResponses: [
        'Yell or get angry',
        'Punish them',
        'Try to reason during the meltdown',
        'Force physical contact',
      ],
      calmingTips: [
        'Remove from overwhelming environment',
        'Deep pressure (if they like it)',
        'Quiet, dark room',
        'Breathing exercises after',
      ],
      category: 'emotional',
    ),
    BehaviorGuideItem(
      id: '5',
      title: 'Difficulty with Transitions',
      emoji: '🔄',
      description: 'Struggles when changing activities or locations',
      reasons: [
        'Need for predictability and routine',
        'Processing time required',
        'Anxiety about the unknown',
        'Attachment to current activity',
      ],
      doResponses: [
        'Give advance warnings (5 minutes, 2 minutes)',
        'Use visual schedules',
        'Create transition routines',
        'Be patient and consistent',
        'Offer choices when possible',
      ],
      dontResponses: [
        'Make sudden changes',
        'Rush them',
        'Get frustrated',
        'Force immediate compliance',
      ],
      calmingTips: [
        'Visual timers',
        'Countdown warnings',
        'Transition objects',
        'Consistent routines',
      ],
      category: 'social',
    ),
    BehaviorGuideItem(
      id: '6',
      title: 'Sensory Seeking',
      emoji: '🌈',
      description: 'Seeking out intense sensory experiences',
      reasons: [
        'Need for sensory input',
        'Self-regulation',
        'Exploration and learning',
        'Feeling under-stimulated',
      ],
      doResponses: [
        'Provide safe sensory activities',
        'Create sensory-rich environment',
        'Offer weighted blankets or vests',
        'Allow movement breaks',
      ],
      dontResponses: [
        'Suppress all sensory behaviors',
        'Ignore sensory needs',
        'Label as "bad behavior"',
      ],
      calmingTips: [
        'Sensory bins',
        'Fidget toys',
        'Movement activities',
        'Textured materials',
      ],
      category: 'sensory',
    ),
  ];

  static List<BehaviorGuideItem> search(String query) {
    if (query.isEmpty) return guides;
    
    final lowerQuery = query.toLowerCase();
    return guides.where((guide) {
      return guide.title.toLowerCase().contains(lowerQuery) ||
             guide.description.toLowerCase().contains(lowerQuery) ||
             guide.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  static BehaviorGuideItem? getById(String id) {
    try {
      return guides.firstWhere((guide) => guide.id == id);
    } catch (e) {
      return null;
    }
  }
}
