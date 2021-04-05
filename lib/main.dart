import 'package:flutter/material.dart';
import 'package:flutter_painting/pages/painting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Painting Demo',
      theme: ThemeData.light(),
      home: PaintingPage(),
    );
  }
}