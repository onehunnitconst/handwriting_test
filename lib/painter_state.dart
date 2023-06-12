import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handwriting_test/my_custom_painter.dart';
import 'package:handwriting_test/path_drawer.dart';
import 'package:handwriting_test/stroke_width_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<File?> saveImage(BuildContext context) async {
    if (await Permission.storage.request().isDenied) {
      return null;
    }

    PictureRecorder pictureRecorder = PictureRecorder();
    Canvas canvas = Canvas(pictureRecorder);
    CustomPainter painter = MyCustomPainter(((canvas, size) {
      for (PathDrawer pathDrawer in previousPathDrawers) {
        pathDrawer.drawPath(canvas);
      }
    }));
    Size size = context.size!;
    print(size);
    painter.paint(canvas, size);
    final data = await pictureRecorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());

    final byte = await data.toByteData(format: ImageByteFormat.png);
    final directory = await getApplicationDocumentsDirectory();
    final File file =
        File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');

    print(file.path);
    await file.writeAsBytes(byte!.buffer.asUint8List());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('저장 완료')));
  }
}
