import 'package:audioplayers/audioplayers.dart';

class AudioFeedbackService {
  final AudioPlayer _player = AudioPlayer();
  bool _enabled = true;

  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  Future<void> playTap() async {
    if (!_enabled) return;
    // Play a simple beep sound
    // In production, you'd load actual sound files
    // For now, we'll just use a placeholder
    // await _player.play(AssetSource('sounds/tap.mp3'));
  }

  Future<void> playSuccess() async {
    if (!_enabled) return;
    // await _player.play(AssetSource('sounds/success.mp3'));
  }

  Future<void> playError() async {
    if (!_enabled) return;
    // await _player.play(AssetSource('sounds/error.mp3'));
  }

  Future<void> playCelebration() async {
    if (!_enabled) return;
    // await _player.play(AssetSource('sounds/celebration.mp3'));
  }

  void dispose() {
    _player.dispose();
  }
}

// Global instance
final audioFeedbackService = AudioFeedbackService();
