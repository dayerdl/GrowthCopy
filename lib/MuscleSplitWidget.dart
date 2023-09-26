import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MusclePart.dart';

class MuscleSplitWidget extends StatelessWidget {
  const MuscleSplitWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HexagonPainter(),
    );
  }
}

class HexagonPainter extends CustomPainter {
  var muscleSplit = {
    MusclePart.LEGS: 5,
    MusclePart.ARMS: 10,
    MusclePart.SHOULDERS: 5,
    MusclePart.CORE: 20,
    MusclePart.CHEST: 20,
    MusclePart.BACK: 50,
  };

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = math.min(size.width / 2, size.height / 2) - 10;

    final Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint textPaint = Paint()
      ..color = Colors.black;
    // ..textBaseline = TextBaseline.alphabetic
    // ..textSize = 16;

    const double angleStep = (2 * math.pi) / 6;
    final List<Offset> vertices = []; //only for reference
    final List<Offset> vertices2 = [];

    for (int i = 0; i < 6; i++) {
      final double angle = i * angleStep;
      final double vertexX = centerX + radius * math.cos(angle);
      final double vertexY = centerY + radius * math.sin(angle);
      vertices.add(Offset(vertexX, vertexY));
    }

    for (int i = 0; i < 6; i++) {
      final double angle = i * angleStep;
      final double vertexX = centerX + radius * math.cos(angle) * muscleSplit.values.elementAt(i)/muscleSplit.values.reduce(max);
      final double vertexY = centerY + radius * math.sin(angle) * muscleSplit.values.elementAt(i)/muscleSplit.values.reduce(max);
      vertices2.add(Offset(vertexX, vertexY));
    }

    // Draw external lines of the hexagon
    final Path hexagonPath = Path();

    // hexagonPath.moveTo(vertices[0].dx, vertices[0].dy);
    // for (int i = 1; i < 6; i++) {
    //   hexagonPath.lineTo(vertices[i].dx, vertices[i].dy);
    // }
    // hexagonPath.close();
    // canvas.drawPath(hexagonPath, strokePaint);


    hexagonPath.moveTo(vertices2[0].dx, vertices2[0].dy);
    for (int i = 1; i < 6; i++) {
      hexagonPath.lineTo(vertices2[i].dx, vertices2[i].dy);
    }
    hexagonPath.close();
    canvas.drawPath(hexagonPath, strokePaint);

    // draw internal lines
    canvas.drawLine(vertices[0], vertices[3], strokePaint);
    canvas.drawLine(vertices[1], vertices[4], strokePaint);
    canvas.drawLine(vertices[2], vertices[5], strokePaint);

    // Draw names for each vertex outside the hexagon
    final List<String> vertexNames = [
      'Legs',
      'Arms',
      'Shoulders',
      'Core',
      'Chest',
      'Back',
    ];

    for (int i = 0; i < 6; i++) {
      final double textOffsetX = 30 * math.cos(angleStep * i);
      final double textOffsetY = 30 * math.sin(angleStep * i);
      var x = centerX + radius * math.cos(angleStep * i) + textOffsetX;
      var y = centerY + radius * math.sin(angleStep * i) + textOffsetY;
      x -= 20;
      y -= 10;
      final Offset textOffset = Offset(x, y);
      canvas.drawText(textOffset, vertexNames[i], textPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

extension CanvasExtension on Canvas {
  void drawText(Offset offset, String text, Paint paint) {
    final TextSpan span =
    TextSpan(text: text, style: TextStyle(color: paint.color));
    final TextPainter textPainter =
    TextPainter(text: span, textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(this, offset);
  }
}