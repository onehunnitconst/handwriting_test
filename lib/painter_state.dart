import 'package:flutter/material.dart';
import 'package:handwriting_test/my_custom_painter.dart';
import 'package:handwriting_test/path_drawer.dart';
import 'package:handwriting_test/stroke_width_type.dart';

class PainterState {
  late CustomPainter painter;
  late PathDrawer currentDrawer;
  late Color selectedColor;
  late StrokeWidthType selectedStrokeWidth;
  late final List<PathDrawer> previousPathDrawers;

  PainterState.clone(PainterState state)
      : selectedColor = state.selectedColor,
        selectedStrokeWidth = state.selectedStrokeWidth,
        previousPathDrawers = state.previousPathDrawers,
        painter = state.painter,
        currentDrawer = state.currentDrawer;

  PainterState() {
    selectedColor = Colors.black;
    selectedStrokeWidth = StrokeWidthType.medium;
    previousPathDrawers = [];
    painter = MyCustomPainter.newBoard;
    currentDrawer = PathDrawer();
  }
}
