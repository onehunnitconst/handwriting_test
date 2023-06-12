import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:handwriting_test/my_custom_painter.dart';
import 'package:handwriting_test/painter_state.dart';
import 'package:handwriting_test/path_drawer.dart';
import 'package:handwriting_test/stroke_width_type.dart';

class PainterStateCubit extends Cubit<PainterState> {
  PainterStateCubit() : super(PainterState());

  void startNewPath(Offset startPoint) {
    PainterState newState = PainterState.clone(state);
    newState.currentDrawer = PathDrawer()
        .setStartPoint(startPoint)
        .setPaintColor(state.selectedColor)
        .setPaintStrokeWidth(state.selectedStrokeWidth.width);
    emit(newState);
  }

  void changeSelectedColor(Color color) {
    PainterState newState = PainterState.clone(state);
    newState.selectedColor = color;
    emit(newState);
  }

  void changeSelectedStrokeWidth(StrokeWidthType strokeWidth) {
    PainterState newState = PainterState.clone(state);
    newState.selectedStrokeWidth = strokeWidth;
    emit(newState);
  }

  void updatePainter(Offset point) {
    PainterState newState = PainterState.clone(state);
    newState.currentDrawer.addPoint(point);
    newState.painter = MyCustomPainter((canvas, size) {
      for (PathDrawer pathDrawer in state.previousPathDrawers) {
        pathDrawer.drawPath(canvas);
      }
      newState.currentDrawer.drawPath(canvas);
    });
    emit(newState);
  }

  void endPath() {
    PainterState newState = PainterState.clone(state);
    newState.previousPathDrawers.add(state.currentDrawer);
    emit(newState);
  }

  void clear() {
    PainterState newState = PainterState.clone(state);
    newState.painter = MyCustomPainter.newBoard;
    newState.currentDrawer = PathDrawer();
    newState.previousPathDrawers.clear();
    emit(newState);
  }
}
