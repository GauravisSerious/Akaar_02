import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About A.A.K.A.R'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            child: const Text('Dashboard'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/detect'),
            child: const Text('Detect Emotion'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/about'),
            child: const Text('About'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
          const Text(
            'A.A.K.A.R',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'AI-Based Assistive Kit for Autism Rehabilitation',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  Text('What is A.A.K.A.R?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 12),
                  Text(
                    'A.A.K.A.R helps recognize emotions from faces and voices to support children on the autism spectrum.\n\n'
                    'It offers a friendly design, clear buttons, and simple feedback.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('How It Works', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 16),
                  Text('1) Face Detection (CNN)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'A CNN (Convolutional Neural Network) analyzes facial features like eyes, mouth, and eyebrows. It learns patterns to recognize emotions from facial expressions.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Text('2) Voice Detection (LSTM)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'An LSTM (Long Short-Term Memory) network listens to voice patterns over time. It analyzes tone, pitch, and rhythm to understand emotional states.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Text('Combined Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'The app combines face and voice results for more accurate emotion detection, like two experts working together.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  Text('Designed for Kids', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 12),
                  Text(
                    'Soft colors, clear icons, and simple messages make it easy to use.\n\n'
                    'We aim for a calm and positive experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
