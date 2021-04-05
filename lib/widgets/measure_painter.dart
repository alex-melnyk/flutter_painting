import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class MeasurePainter extends CustomPainter {
  const MeasurePainter({
    this.value = 0.0,
    this.circleWith = 2.0,
    this.divisions = 24,
  });

  final double value;
  final double circleWith;
  final double divisions;

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
      ..color = ColorTween(
        begin: Colors.green,
        end: Colors.red,
      ).transform(value)
      ..isAntiAlias = true;

    final arrowPath = Path()
      ..moveTo(offsetCenter.dx - 3, offsetCenter.dy)
      ..lineTo(offsetCenter.dx, 10.0)
      ..lineTo(offsetCenter.dx + 3, offsetCenter.dy)
      ..close();

    canvas.save();
    canvas.translate(offsetCenter.dx, offsetCenter.dy);
    canvas.rotate(radians(360.0 * value));
    canvas.translate(-offsetCenter.dx, -offsetCenter.dy);

    canvas.drawPath(arrowPath, paint);
    canvas.restore();
  }

  void _drawDivisions(Canvas canvas, Size size) {
    final paint = Paint();

    final divisionDegrees = 360.0 / divisions;

    canvas.translate(size.width / 2, size.height / 2);
    for (var i = 0; i < divisions; i++) {
      final stepDegrees = divisionDegrees * i;
      final offsetAngle = _angleToPoint(90.0, -divisionDegrees * i - 90);

      canvas.save();

      paint.color = ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ).transform(stepDegrees / 360.0);

      canvas.drawCircle(offsetAngle, 2, paint);
      canvas.restore();
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
