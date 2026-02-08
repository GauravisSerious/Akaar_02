import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';

class ChatbotProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String _currentMode = 'kid'; // 'kid', 'parent', 'teacher'

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String get currentMode => _currentMode;

  void setMode(String mode) {
    _currentMode = mode;
    notifyListeners();
  }

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
