enum UserRole {
  child,
  parent,
  teacher,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.child:
        return 'Child';
      case UserRole.parent:
        return 'Parent';
      case UserRole.teacher:
        return 'Teacher';
    }
  }

  String get emoji {
    switch (this) {
      case UserRole.child:
        return '🧒';
      case UserRole.parent:
        return '👨‍👩‍👧';
      case UserRole.teacher:
        return '🧑‍🏫';
    }
  }

  String get description {
    switch (this) {
      case UserRole.child:
        return 'Learn about emotions and play games';
      case UserRole.parent:
        return 'Track your child\'s emotional journey';
      case UserRole.teacher:
        return 'Monitor classroom emotional health';
    }
  }
}
