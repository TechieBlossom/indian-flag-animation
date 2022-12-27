import 'package:flutter/material.dart';
import 'package:indian_flag/sizes.dart';

class Dot extends StatelessWidget {
  const Dot({
    Key? key,
    this.color = Colors.white,
    this.size = dotSize,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromRadius(size),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: size,
              spreadRadius: size,
            ),
          ],
        ),
      ),
    );
  }
}
