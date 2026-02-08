# ML Models

Place your TensorFlow Lite models here:

1. **cnn_model.tflite** - Face emotion detection (CNN)
2. **lstm_model.tflite** - Voice emotion detection (LSTM)

## Converting .h5 to .tflite

If you have `.h5` models, convert them using Python:

```python
import tensorflow as tf

# Convert CNN model
model = tf.keras.models.load_model('cnn_model.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()
with open('cnn_model.tflite', 'wb') as f:
    f.write(tflite_model)

# Convert LSTM model
model = tf.keras.models.load_model('lstm_model.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()
with open('lstm_model.tflite', 'wb') as f:
    f.write(tflite_model)
```

Then copy the `.tflite` files to this folder.
