import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Confetti overlay for celebrations
class ConfettiOverlay extends StatefulWidget {
  final Widget child;
  final bool show;
  
  const ConfettiOverlay({
    super.key,
    required this.child,
    this.show = false,
  });
  
  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    
    if (widget.show) {
      _controller.repeat();
    }
  }
  
  @override
  void didUpdateWidget(ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.show && _controller.isAnimating) {
      _controller.stop();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.show)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _ConfettiPainter(_controller.value),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final double progress;
  final math.Random random = math.Random(42);
  
  _ConfettiPainter(this.progress);
  
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFFFFE66D),
      const Color(0xFFFFB4A2),
      const Color(0xFF88DEB8),
      const Color(0xFF8B7FD6),
      const Color(0xFF6EC8E8),
    ];
    
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = (progress * size.height) + (i * 20);
      final rotation = progress * math.pi * 4 + i;
      final color = colors[i % colors.length];
      
      if (y < size.height) {
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(rotation);
        
        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        
        final path = Path()
          ..moveTo(0, -5)
          ..lineTo(5, 5)
          ..lineTo(-5, 5)
          ..close();
        
        canvas.drawPath(path, paint);
        canvas.restore();
      }
    }
  }
  
  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) => true;
}
