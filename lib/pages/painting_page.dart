import 'package:flutter/material.dart';
import 'package:flutter_painting/widgets/measure_painter.dart';

class PaintingPage extends StatefulWidget {
  @override
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      value: 0.125,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: CustomPaint(
                    painter: MeasurePainter(
                      value: _animationController.value,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _animationController
                    ..value = 0.0
                    ..forward();
                },
                child: Text('Animate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
