import 'package:flutter/material.dart';
import '../../theme.dart';

/// 🌿 Calm Mode - Therapeutic breathing experience
class CalmModePage extends StatefulWidget {
  const CalmModePage({super.key});

  @override
  State<CalmModePage> createState() => _CalmModePageState();
}

class _CalmModePageState extends State<CalmModePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String _instruction = 'Breathe In';
  int _selectedDuration = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _instruction = 'Breathe Out');
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _instruction = 'Breathe In');
        _controller.forward();
      }
    });
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.calmGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // ❌ Close button
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(51),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // 😌 Mascot
                        const Text('😌', style: TextStyle(fontSize: 60)),
                        
                        const SizedBox(height: 16),
                        
                        const Text(
                          'Calm Mode',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          'Take a moment to relax',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // 🔵 Breathing Circle
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Container(
                              width: 180 * _scaleAnimation.value,
                              height: 180 * _scaleAnimation.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withAlpha(51),
                                border: Border.all(
                                  color: Colors.white.withAlpha(128),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withAlpha(51),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  _instruction,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // ⏱️ Timer Selection
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(26),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTimerButton(5),
                              _buildTimerButton(10),
                              _buildTimerButton(15),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // 💡 Tip
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(26),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '🌱 Follow the circle and breathe slowly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildTimerButton(int minutes) {
    final isSelected = _selectedDuration == minutes;
    return GestureDetector(
      onTap: () => setState(() => _selectedDuration = minutes),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          '$minutes min',
          style: TextStyle(
            color: isSelected ? AppColors.primaryPurple : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
