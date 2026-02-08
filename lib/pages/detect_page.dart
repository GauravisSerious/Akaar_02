 import 'dart:io';

 import 'package:file_picker/file_picker.dart';
 import 'package:flutter/material.dart';
 import 'package:image_picker/image_picker.dart';
 import 'package:flutter_spinkit/flutter_spinkit.dart';

 import '../shared/emotions.dart';
 import '../services/ml_service.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({super.key});

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  final ImagePicker _imagePicker = ImagePicker();
  final MLService _mlService = MLService();
  XFile? _image;
  File? _audio;
  XFile? _video;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _mlService.initialize();
  }

  @override
  void dispose() {
    _mlService.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = picked);
    }
  }

  Future<void> _captureImage() async {
    final XFile? picked = await _imagePicker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _image = picked);
    }
  }

  Future<void> _pickAudio() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['wav', 'mp3', 'ogg', 'm4a']);
    if (res != null && res.files.single.path != null) {
      setState(() => _audio = File(res.files.single.path!));
    }
  }

  Future<void> _pickVideo() async {
    final XFile? picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _video = picked);
    }
  }

  Future<void> _captureVideo() async {
    final XFile? picked = await _imagePicker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 30));
    if (picked != null) {
      setState(() => _video = picked);
    }
  }

  Future<void> _analyzeFace() async {
    if (_image == null) {
      _snack('Please choose an image first');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final probs = await _mlService.predictFace(_image!.path);
      final label = Emotions.argMax(probs);
      if (mounted) {
        Navigator.pushNamed(context, '/results', arguments: {
          'finalLabel': label,
          'finalConf': probs[label],
          'emoji': Emotions.emoji[label],
          'feedback': 'You look ${label.toLowerCase()}! 😊'
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _analyzeVoice() async {
    if (_audio == null) {
      _snack('Please choose an audio file first');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final probs = await _mlService.predictVoice(_audio!.path);
      final label = Emotions.argMax(probs);
      if (mounted) {
        Navigator.pushNamed(context, '/results', arguments: {
          'finalLabel': label,
          'finalConf': probs[label],
          'emoji': Emotions.emoji[label],
          'feedback': 'You sound ${label.toLowerCase()}! 🎵'
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _analyzeVideo() async {
    if (_video == null) {
      _snack('Please choose a video first');
      return;
    }
    setState(() => _isLoading = true);
    try {
      // For video, we'll use face detection on first frame (simplified)
      final probs = await _mlService.predictFace(_video!.path);
      final label = Emotions.argMax(probs);
      if (mounted) {
        Navigator.pushNamed(context, '/results', arguments: {
          'finalLabel': label,
          'finalConf': probs[label],
          'emoji': Emotions.emoji[label],
          'feedback': 'Your video shows ${label.toLowerCase()} vibes! 🎥'
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _analyzeBoth() async {
    if (_image == null || _audio == null) {
      _snack('Pick both image and audio to analyze together');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final face = await _mlService.predictFace(_image!.path);
      final voice = await _mlService.predictVoice(_audio!.path);
      final combined = Emotions.combineWeighted(face, voice);
      final label = Emotions.argMax(combined);
      if (mounted) {
        Navigator.pushNamed(context, '/results', arguments: {
          'finalLabel': label,
          'finalConf': combined[label],
          'emoji': Emotions.emoji[label],
          'feedback': 'You look and sound ${label.toLowerCase()}! 🎯'
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Emotion'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          IconButton(
            icon: const Icon(Icons.dashboard),
            tooltip: 'Dashboard',
            onPressed: () => Navigator.pushReplacementNamed(context, '/role-selection'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Face Image', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.photo, size: 20),
                          label: const Text('Gallery'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _captureImage,
                          icon: const Icon(Icons.photo_camera, size: 20),
                          label: const Text('Camera'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_image!.path),
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Text('No image selected'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Face Video', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickVideo,
                          icon: const Icon(Icons.video_library, size: 20),
                          label: const Text('Gallery'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _captureVideo,
                          icon: const Icon(Icons.videocam, size: 20),
                          label: const Text('Record'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(_video != null ? File(_video!.path).path.split(Platform.pathSeparator).last : 'No video selected'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Voice Audio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _pickAudio,
                      icon: const Icon(Icons.audiotrack),
                      label: const Text('Pick Audio'),
                    ),
                    const SizedBox(height: 12),
                    Text(_audio?.path.split(Platform.pathSeparator).last ?? 'No audio selected'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              Center(
                child: Column(
                  children: const [
                    SpinKitFadingCircle(color: Color(0xFF5DADE2), size: 50),
                    SizedBox(height: 12),
                    Text('Analyzing emotions...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            else
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _analyzeFace,
                    icon: const Icon(Icons.face, size: 20),
                    label: const Text('Analyze Face'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _analyzeVoice,
                    icon: const Icon(Icons.mic, size: 20),
                    label: const Text('Analyze Voice'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _analyzeVideo,
                    icon: const Icon(Icons.videocam, size: 20),
                    label: const Text('Analyze Video'),
                  ),
                  if (_image != null && _audio != null)
                    ElevatedButton.icon(
                      onPressed: _analyzeBoth,
                      icon: const Icon(Icons.analytics, size: 20),
                      label: const Text('Analyze Both'),
                    ),
                ],
              ),
            const SizedBox(height: 16),
          ],
          ),
        ),
      ),
    );
  }
}
