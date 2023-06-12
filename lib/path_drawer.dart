import 'package:flutter/material.dart';

class PathDrawer {
  late Offset _startPoint;
  late List<Offset> _points;
  late Paint _paint;

  PathDrawer() {
    _startPoint = Offset.zero;
    _points = [];
    _paint = Paint();
    _paint.style = PaintingStyle.stroke;
    _paint.strokeCap = StrokeCap.round;
  }

  PathDrawer setStartPoint(Offset startPoint) {
    _startPoint = startPoint;
    return this;
  }

  PathDrawer setPaintColor(Color color) {
    _paint.color = color;
    return this;
  }

  PathDrawer setPaintStrokeWidth(double width) {
    _paint.strokeWidth = width;
    return this;
  }

  void addPoint(Offset point) {
    _points.add(point);
  }

  void drawPath(Canvas canvas) {
    Path path = Path();

    path.moveTo(_startPoint.dx, _startPoint.dy);
    for (final point in _points) {
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, _paint);
  }
}
