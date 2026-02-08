import 'package:flutter/material.dart';
import 'dart:async';

class BreathingExercisePage extends StatefulWidget {
  const BreathingExercisePage({super.key});

  @override
  State<BreathingExercisePage> createState() => _BreathingExercisePageState();
}

class _BreathingExercisePageState extends State<BreathingExercisePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  String _instruction = 'Breathe In';
  int _count = 4;
  Timer? _timer;
  int _phase = 0; // 0: breathe in, 1: hold, 2: breathe out, 3: hold
  final List<int> _durations = [4, 7, 8, 0]; // 4-7-8 breathing pattern

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startBreathingCycle();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startBreathingCycle() {
    _updatePhase();
  }

  void _updatePhase() {
    _timer?.cancel();
    
    if (_phase == 0) {
      // Breathe in
      setState(() {
        _instruction = 'Breathe In';
        _count = _durations[0];
      });
      _controller.forward();
      _startCountdown(_durations[0], 1);
    } else if (_phase == 1) {
      // Hold
      setState(() {
        _instruction = 'Hold';
        _count = _durations[1];
      });
      _startCountdown(_durations[1], 2);
    } else if (_phase == 2) {
      // Breathe out
      setState(() {
        _instruction = 'Breathe Out';
        _count = _durations[2];
      });
      _controller.reverse();
      _startCountdown(_durations[2], 3);
    } else {
      // Short pause before next cycle
      _phase = 0;
      Future.delayed(const Duration(milliseconds: 500), _updatePhase);
      return;
    }
  }

  void _startCountdown(int seconds, int nextPhase) {
    int remaining = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining--;
      if (remaining > 0) {
        setState(() {
          _count = remaining;
        });
      } else {
        timer.cancel();
        _phase = nextPhase;
        _updatePhase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E88E5).withOpacity(0.7),
              const Color(0xFF7E57C2).withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Exit button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 32),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              const Spacer(),

              // Title
              const Text(
                'Breathing Exercise',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '4-7-8 Pattern',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 40),

              // Breathing circle animation
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 300 * _animation.value,
                    height: 300 * _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _count.toString(),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Instruction
              Text(
                _instruction,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              // Info
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Follow the circle and breathe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'In: 4s • Hold: 7s • Out: 8s',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
