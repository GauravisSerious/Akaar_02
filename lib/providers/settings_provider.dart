import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  bool _soundEffectsEnabled = true;
  bool _ttsEnabled = true;
  bool _colorBlindMode = false;
  double _ttsSpeed = 1.0;

  bool get soundEffectsEnabled => _soundEffectsEnabled;
  bool get ttsEnabled => _ttsEnabled;
  bool get colorBlindMode => _colorBlindMode;
  double get ttsSpeed => _ttsSpeed;

  void toggleSoundEffects() {
    _soundEffectsEnabled = !_soundEffectsEnabled;
    notifyListeners();
  }

  void toggleTTS() {
    _ttsEnabled = !_ttsEnabled;
    notifyListeners();
  }

  void toggleColorBlindMode() {
    _colorBlindMode = !_colorBlindMode;
    notifyListeners();
  }

  void setTTSSpeed(double speed) {
    _ttsSpeed = speed;
    notifyListeners();
  }

  void loadSettings({
    required bool soundEffects,
    required bool tts,
    required bool colorBlind,
    required double ttsSpeed,
  }) {
    _soundEffectsEnabled = soundEffects;
    _ttsEnabled = tts;
    _colorBlindMode = colorBlind;
    _ttsSpeed = ttsSpeed;
    notifyListeners();
  }
}
