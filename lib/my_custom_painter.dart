import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  final void Function(Canvas, Size)? repaint;

  MyCustomPainter(this.repaint);

  static get newBoard => MyCustomPainter(null);

  @override
  void paint(Canvas canvas, Size size) {
    if (repaint != null) {
      repaint!(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}