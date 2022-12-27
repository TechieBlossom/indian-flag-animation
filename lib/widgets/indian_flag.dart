import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indian_flag/widgets/ap.dart';
import 'package:indian_flag/widgets/dot.dart';
import 'package:indian_flag/colors.dart';
import 'package:indian_flag/sizes.dart';

class IndianFlag extends StatelessWidget {
  const IndianFlag({
    Key? key,
    required this.sw,
    required this.sh,
    required this.animated,
  }) : super(key: key);

  final double sw;
  final double sh;
  final bool animated;

  Dot get saffron => const Dot(color: AppColors.saffron);

  Dot get white => const Dot(color: AppColors.white);

  Dot get green => const Dot(color: AppColors.green);

  Dot get navyBlue => const Dot(
        color: AppColors.navyBlue,
        size: dotSize / 2,
      );

  double get subjectWidth => sw - 40;

  double get subjectHeight => subjectWidth * 2 / 3;

  double get startX => (sw - subjectWidth) / 2 + dotSize / 2;

  double get startY => 100;

  int get dotsPerRow => subjectWidth ~/ dotSize;

  int get rowsPerColor => subjectHeight ~/ dotSize ~/ 3;

  double get radiusOfChakra => (rowsPerColor ~/ 2) * dotSize;

  Random get random => Random();

  int get swInt => sw.toInt();

  int get shInt => sh.toInt();

  List<Offset> _finalColoredDotOffsets(int rowNumber) {
    final dy = startY + (rowNumber * dotSize);
    return List.generate(
      dotsPerRow,
      (index) => Offset((index * dotSize) + startX, dy),
    );
  }

  List<AP> get _allFinalDots => List.of(
        [
          for (int i = 0; i < rowsPerColor; i++)
            ..._generateFinalSaffronDots(i),
          for (int i = rowsPerColor; i < rowsPerColor * 2; i++)
            ..._generateFinalWhiteDots(i),
          for (int i = rowsPerColor * 2; i < rowsPerColor * 3; i++)
            ..._generateFinalGreenDots(i),
          ..._generateFinalChakraDots(),
          for (int i = 1; i < rowsPerColor; i++)
            ..._generateFinalChakraInnerDots(i)
        ],
      );

  List<AP> get _allInitialDots => List.of(
        [
          ..._generateInitialDots(saffron, rowsPerColor),
          ..._generateInitialDots(white, rowsPerColor),
          ..._generateInitialDots(green, rowsPerColor),
          ..._generateInitialChakraDots(24, dotSize),
          ..._generateInitialChakraDots(24 * (rowsPerColor - 1), dotSize / 3),
        ],
      );

  List<AP> _generateInitialChakraDots(int number, double dotSize) {
    final randomX =
        List.generate(number, (index) => random.nextInt(swInt).toDouble());
    final randomY =
        List.generate(number, (index) => random.nextInt(shInt).toDouble());
    return List.generate(
      number,
      (index) => AP(
        offset: Offset(randomX[index], randomY[index]),
        size: dotSize,
        child: navyBlue,
      ),
    );
  }

  List<AP> _generateInitialDots(Widget child, int number) {
    int n = dotsPerRow * number;
    final randomX =
        List.generate(n, (index) => random.nextInt(swInt).toDouble());
    final randomY =
        List.generate(n, (index) => random.nextInt(shInt).toDouble());
    return List.generate(
      n,
      (index) => AP(
        offset: Offset(randomX[index], randomY[index]),
        child: child,
      ),
    );
  }

  List<Offset> _finalChakraOffsets() {
    final center = Offset(
      startX + (dotsPerRow ~/ 2 * dotSize),
      startY + (rowsPerColor * 3 ~/ 2 * dotSize),
    );

    final list = List<Offset>.empty(growable: true);
    for (int i = 0; i < 24; i++) {
      final degree = 15 * i;
      final x = radiusOfChakra * cos(pi * 2 * degree / 360) + center.dx;
      final y = radiusOfChakra * sin(pi * 2 * degree / 360) + center.dy;
      list.add(Offset(x, y));
    }
    return list;
  }

  List<Offset> _finalChakraInnerOffsets(int ring) {
    final center = Offset(
      startX + (dotsPerRow ~/ 2 * dotSize),
      startY + (rowsPerColor * 3 ~/ 2 * dotSize),
    );

    final list = List<Offset>.empty(growable: true);
    for (int i = 0; i < 24; i++) {
      final degree = 15 * i;
      final x =
          radiusOfChakra * (ring / rowsPerColor) * cos(pi * 2 * degree / 360) +
              center.dx;
      final y =
          radiusOfChakra * (ring / rowsPerColor) * sin(pi * 2 * degree / 360) +
              center.dy;
      list.add(Offset(x, y));
    }
    return list;
  }

  List<AP> _generateFinalChakraDots() {
    return _finalChakraOffsets().map((offset) {
      return AP(
        offset: offset,
        size: dotSize - 2,
        duration: const Duration(seconds: 8),
        child: navyBlue,
      );
    }).toList();
  }

  List<AP> _generateFinalChakraInnerDots(int ring) {
    return _finalChakraInnerOffsets(ring).map((offset) {
      return AP(
        offset: offset,
        size: dotSize / 3,
        duration: const Duration(seconds: 8),
        child: navyBlue,
      );
    }).toList();
  }

  List<AP> _generateFinalSaffronDots(int rowNumber) {
    return _finalColoredDotOffsets(rowNumber).map((offset) {
      return AP(offset: offset, child: saffron);
    }).toList();
  }

  List<AP> _generateFinalWhiteDots(int rowNumber) {
    return _finalColoredDotOffsets(rowNumber).map((offset) {
      return AP(offset: offset, child: white);
    }).toList();
  }

  List<AP> _generateFinalGreenDots(int rowNumber) {
    return _finalColoredDotOffsets(rowNumber).map((offset) {
      return AP(offset: offset, child: green);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (animated) ..._allFinalDots,
        if (!animated) ..._allInitialDots,
      ],
    );
  }
}
