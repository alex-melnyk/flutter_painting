import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class MeasurePainter extends CustomPainter {
  const MeasurePainter({
    this.value = 0.0,
    this.circleWith = 2.0,
    this.divisions = 24,
    this.minAngle = -135.0,
    this.maxAngle = 135.0,
  }) : assert(minAngle < maxAngle, 'minAngle < maxAngle');

  final double value;
  final double circleWith;
  final int divisions;
  final double minAngle;
  final double maxAngle;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, size);

    _drawArrow(canvas, size);

    _drawDivisions(canvas, size);
  }

  void _drawCircle(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(
        size.width / 2,
        size.height / 2,
      ),
      100.0 - circleWith / 2,
      Paint()
        ..color = Colors.black38
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleWith,
    );
  }

  void _drawArrow(Canvas canvas, Size size) {
    final offsetCenter = Offset(
      size.width / 2,
      size.height / 2,
    );

    final paint = Paint()
      ..color = Colors.black26
      ..isAntiAlias = true;

    final arrowBottomWidth = 5.0 / 2.0;

    // Build arrow path.
    final arrowPath = Path()
      ..moveTo(offsetCenter.dx - arrowBottomWidth, offsetCenter.dy)
      ..lineTo(offsetCenter.dx, 20.0)
      ..lineTo(offsetCenter.dx + arrowBottomWidth, offsetCenter.dy)
      ..close();

    // Draw arrow center center circle
    canvas.drawCircle(offsetCenter, arrowBottomWidth * 2, paint);

    paint.color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).transform(value);

    // Draw arrow bottom rounding.
    canvas.drawCircle(offsetCenter, arrowBottomWidth, paint);

    // Save canvas state.
    canvas.save();

    // Translate canvas to rotate from canter.
    canvas.translate(offsetCenter.dx, offsetCenter.dy);

    // Rotate canvas.
    canvas.rotate(radians(Tween<double>(
      begin: minAngle,
      end: maxAngle,
    ).transform(value)));

    // Translate canvas back.
    canvas.translate(-offsetCenter.dx, -offsetCenter.dy);

    // Draw path on rotated canvas.
    canvas.drawPath(arrowPath, paint);

    // Reset canvas manipulation.
    canvas.restore();
  }

  void _drawDivisions(Canvas canvas, Size size) {
    // Translate canvas to draw from center.
    canvas.translate(size.width / 2, size.height / 2);

    final paint = Paint();

    // Calculate total degrees to paint.
    final totalDegrees = (minAngle - maxAngle).abs();
    // Calculate common division angle.
    final divisionDegrees = totalDegrees / (divisions - 1);

    // Draw divisions on the canvas.
    for (var i = 0; i < divisions; i++) {
      // Calculate angle by division index.
      final stepDegrees = divisionDegrees * i;
      // Get division point based radius and stepDegrees.
      final offsetAngle = _angleToPoint(
        90.0,
        divisionDegrees * i - 90 + minAngle,
      );

      // Set paint color based on division angle.
      paint.color = ColorTween(
        begin: Colors.green,
        end: Colors.red,
      ).transform(stepDegrees / totalDegrees);

      // Draw division.
      canvas.drawCircle(offsetAngle, 5, paint);
    }
  }

  Offset _angleToPoint(double radius, double angle) {
    return Offset(
      radius * cos(pi * angle / 180),
      radius * sin(pi * angle / 180),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
