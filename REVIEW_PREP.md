# A.A.K.A.R – Review Preparation Document

Version: Oct 2025

## 1) One‑Minute Overview
A.A.K.A.R (AI‑Based Assistive Kit for Autism Rehabilitation) is a Flutter app that recognizes emotions from face images and voice audio to support children on the autism spectrum. It features a clean, kid‑friendly interface, on‑device ML via TensorFlow Lite for privacy/low latency, and deterministic mock predictions for consistent demos when models are missing.

## 2) Core Features
- Face emotion detection (image)
  - Real on‑device ML when `cnn_model.tflite` is present; otherwise seeded mock.
- Voice emotion detection (audio)
  - Currently seeded mock until MFCC preprocessing + LSTM model are added.
- Video (simple)
  - Uses image pipeline conceptually; UI allows selecting/recording video.
- Combined inference
  - Weighted merge of face + voice probabilities.
- Results view
  - Final label, confidence, emoji, short feedback.
- About view
  - Layperson explanation of CNN/LSTM and kid‑friendly design.
- Smooth UX
  - SafeArea everywhere, consistent AppBar actions, loading spinner during analysis.

## 3) Tech Stack
- Framework: Flutter (Dart)
- ML: `tflite_flutter` (on‑device TensorFlow Lite)
- Image preprocessing: `image`
- Media: `image_picker`, `file_picker`
- UX: `flutter_spinkit` (loading), Material Icons

## 4) Project Layout (key files)
- `lib/main.dart` – App entry, routes, theme; `debugShowCheckedModeBanner: false`.
- `lib/pages/home_page.dart` – Landing page with actions.
- `lib/pages/dashboard_page.dart` – Role cards; navigation button to Detect.
- `lib/pages/detect_page.dart` – Pick/capture media + Analyze buttons.
- `lib/pages/results_page.dart` – Shows label, confidence, emoji, feedback.
- `lib/pages/about_page.dart` – Explanation of approach and design.
- `lib/services/ml_service.dart` – Loads TFLite models; image preprocessing; inference; fallback.
- `lib/shared/emotions.dart` – Emotion labels, emojis, seeded mock probabilities, helpers.
- `assets/models/` – Place `cnn_model.tflite`, `lstm_model.tflite` (optional).
- `assets/icon/` – App icon input (`app_icon.png`).
- `ML_SETUP.md` – How to convert/load models.
- `ICON_SETUP.md` – How to set a custom app icon.
- `pubspec.yaml` – Dependencies and asset configuration.

## 5) Data Flow (high level)
1. User picks image/audio (or records).
2. Detect Page calls `MLService` methods.
3. Face: image -> 48×48 grayscale tensor -> TFLite CNN -> logits -> softmax -> probabilities.
4. Voice: (currently mock) returns seeded probabilities.
5. Combined: weighted average of probabilities.
6. Results Page displays label, confidence, emoji, and feedback.

## 6) ML Details
- Models expected in `assets/models/`:
  - `cnn_model.tflite` (Face/CNN) – Input `[1, 48, 48, 1]`, Output `[1, 7]`.
  - `lstm_model.tflite` (Voice/LSTM) – Planned; MFCC preprocessing pending.
- `MLService.initialize()` loads models if present.
- `predictFace(path)`
  - Preprocess: resize 48×48, grayscale, normalize 0–1.
  - Runs interpreter; applies softmax; returns `{label: prob}` map.
  - On error/missing model: seeded mock via `Emotions.mockProbs()`.
- `predictVoice(path)`
  - Currently returns seeded mock; TODO: MFCC + LSTM inference.

## 7) UX/Design Choices
- Consistent AppBar across pages; navigation uses `pushReplacementNamed` to avoid stacking.
- Minimal emojis; Material Icons for clarity.
- Cards with padding, rounded corners; large, accessible buttons.
- SafeArea on all pages to avoid system UI overlap.

## 8) How to Run (Dev)
```bash
cd d:\Study\practice\AKAAR\aakar_app
flutter pub get
flutter run
```

## 9) Enable Real ML (Face)
1. Convert Keras `.h5` to `.tflite` (see `ML_SETUP.md`).
2. Copy `cnn_model.tflite` to `assets/models/`.
3. Ensure `assets/models/` is listed under `assets:` in `pubspec.yaml`.
4. `flutter pub get` → `flutter run`.

Voice will remain mocked until MFCC + `lstm_model.tflite` are integrated.

## 10) Demo Script (3–5 minutes)
- Home → explain problem/solution.
- Dashboard → show roles; tap "Continue to Emotion Detection".
- Detect → Pick an image → Analyze Face → Results.
- (Optional) Pick audio → Analyze Voice (mock) → back → Analyze Both.
- About → Explain CNN/LSTM and combined approach + kid‑friendly design.

## 11) Q&A Cheat Sheet
- Is it real ML?
  - Face: Yes, with `cnn_model.tflite`. Voice: mock until MFCC+LSTM added.
- Why on‑device TFLite?
  - Privacy, offline capability, low latency, no server costs.
- Accuracy?
  - Depends on trained model; app provides robust inference pipeline.
- Next steps?
  - Implement MFCC preprocessing for voice; add video frame extraction; dataset evaluation & metrics; privacy/consent UX.

## 12) Dependencies (pubspec excerpts)
- `tflite_flutter: ^0.11.0` – TensorFlow Lite runtime
- `image: ^4.0.17` – Image preprocessing
- `image_picker: ^1.2.0`, `file_picker: ^10.3.3` – Media input
- `flutter_spinkit: ^5.2.2` – Loading animations
- `permission_handler: ^12.0.1`, `audioplayers: ^6.5.1` – Platform features

## 13) Known Limitations & Roadmap
- Voice: add MFCC feature extraction + LSTM inference wiring.
- Video: add proper frame extraction + batching.
- Model evaluation: add test dataset hooks and metrics UI.
- Accessibility: optional TTS feedback; color‑blind friendly palettes.

## 14) Risks & Mitigations
- Missing models → deterministic mocks ensure demo stability.
- Platform camera/mic permissions → add to AndroidManifest, test early.
- Model size/perf → consider quantization (`Optimize.DEFAULT`) during conversion.

## 15) Talking Points (at a glance)
- Purpose: assist emotion understanding for kids with autism.
- Approach: multi‑modal (face + voice), on‑device ML, privacy‑first.
- Design: simple, accessible UI, consistent navigation, minimal distractions.
- Current: face ML ready (with model); voice mocked; video simplified.
- Future: MFCC + LSTM, video frames, metrics, clinical validation.
