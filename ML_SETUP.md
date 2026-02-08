# 🤖 ML Model Setup Instructions

## Quick Start

Your app is now ready for real ML inference! Follow these steps to add your trained models:

---

## 📦 Step 1: Convert Your Models to TFLite

If you have `.h5` Keras models, convert them to TensorFlow Lite format:

```python
import tensorflow as tf

# Convert Face CNN Model
face_model = tf.keras.models.load_model('path/to/cnn_model.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(face_model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]  # Optional: optimize for mobile
tflite_face = converter.convert()

with open('cnn_model.tflite', 'wb') as f:
    f.write(tflite_face)

# Convert Voice LSTM Model
voice_model = tf.keras.models.load_model('path/to/lstm_model.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(voice_model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_voice = converter.convert()

with open('lstm_model.tflite', 'wb') as f:
    f.write(tflite_voice)
```

---

## 📁 Step 2: Add Models to Your App

1. Copy the `.tflite` files to:
   ```
   aakar_app/assets/models/cnn_model.tflite
   aakar_app/assets/models/lstm_model.tflite
   ```

2. The app will automatically load them on startup!

---

## 🎯 Expected Model Specs

### Face Model (CNN)
- **Input**: `[1, 48, 48, 1]` (grayscale image, 48x48 pixels, normalized 0-1)
- **Output**: `[1, 7]` (probabilities for 7 emotions)
- **Emotions**: Angry, Disgust, Fear, Happy, Sad, Surprise, Neutral

### Voice Model (LSTM)
- **Input**: `[1, 40, 100, 1]` (MFCC features: 40 coefficients, 100 time steps)
- **Output**: `[1, 7]` (probabilities for 7 emotions)
- **Emotions**: Angry, Disgust, Fear, Happy, Sad, Surprise, Neutral

> **Note**: Audio preprocessing (MFCC extraction) is not yet implemented in Flutter. The app will fall back to mock predictions for voice until you add audio processing or use a backend API.

---

## 🔄 Fallback Behavior

If models are not found:
- ✅ The app will use **deterministic mock predictions** (seeded by file path)
- ✅ Results will be consistent for the same file
- ✅ Predictions are biased toward common emotions (Happy, Neutral) for realistic feel
- ⚠️ Not real ML, but good for UI testing!

---

## 🚀 Alternative: Backend API

If models are too large or you want easier iteration:

1. Host your `.h5` models in a Flask/FastAPI server
2. Modify `lib/services/ml_service.dart` to call your API instead of TFLite
3. Send image/audio as base64 or multipart form data
4. Return probabilities as JSON

Example API endpoint:
```python
@app.post("/predict/face")
async def predict_face(file: UploadFile):
    # Load image, preprocess, run model
    probs = model.predict(preprocessed_image)
    return {"probabilities": probs.tolist()}
```

---

## 🎨 Current UI Features

✅ Kid-friendly emojis throughout the app  
✅ Cartoonish About page with illustrations  
✅ Loading spinner during analysis  
✅ Responsive Dashboard with adaptive grid  
✅ SafeArea to prevent Android button clashes  
✅ Enhanced theme with vibrant colors and shadows  

---

## 📱 Android Permissions

For camera and video to work on real devices, add to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    
    <application ...>
        ...
    </application>
</manifest>
```

---

## 🧪 Testing

1. **Without models**: App uses mock predictions (deterministic, biased toward Happy/Neutral)
2. **With face model only**: Real face predictions, mock voice predictions
3. **With both models**: Full ML inference for face and voice!

---

## 🛠️ Need Help?

- Check `lib/services/ml_service.dart` for the ML service implementation
- Logs will show if models loaded successfully or fell back to mocks
- Use `flutter run -v` to see detailed logs

Happy coding! 🎉
