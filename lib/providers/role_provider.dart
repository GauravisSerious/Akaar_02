import 'package:flutter/foundation.dart';
import '../models/user_role.dart';

class RoleProvider with ChangeNotifier {
  UserRole? _selectedRole;

  UserRole? get selectedRole => _selectedRole;

  bool get hasRole => _selectedRole != null;

  void selectRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setRole(String roleString) {
    switch (roleString.toLowerCase()) {
      case 'child':
        selectRole(UserRole.child);
        break;
      case 'parent':
        selectRole(UserRole.parent);
        break;
      case 'teacher':
        selectRole(UserRole.teacher);
        break;
      default:
        throw ArgumentError('Invalid role: $roleString');
    }
  }

  void clearRole() {
    _selectedRole = null;
    notifyListeners();
  }
}
