import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 32,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo icon - green "a" in a circle
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF58D68D),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'a',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.6,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            'AAKAR',
            style: TextStyle(
              fontSize: size * 0.7,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}
