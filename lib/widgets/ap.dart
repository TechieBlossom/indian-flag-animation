import 'package:flutter/material.dart';
import 'package:indian_flag/sizes.dart';

class AP extends StatelessWidget {
  const AP({
    Key? key,
    required this.offset,
    required this.child,
    this.size = dotSize,
    this.duration = const Duration(seconds: 6),
  }) : super(key: key);

  final Offset offset;
  final Widget child;
  final double size;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned.fromRect(
      duration: duration,
      curve: Curves.linearToEaseOut,
      rect: Rect.fromCenter(
        center: offset,
        width: size,
        height: size,
      ),
      child: child,
    );
  }
}
