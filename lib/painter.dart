import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:handwriting_test/color_palette.dart';
import 'package:handwriting_test/save_button.dart';
import 'package:handwriting_test/erase_button.dart';
import 'package:handwriting_test/painter_state.dart';
import 'package:handwriting_test/painter_state_cubit.dart';
import 'package:handwriting_test/stroke_width_list.dart';
import 'package:handwriting_test/stroke_width_type.dart';

class Painter extends StatelessWidget {
  final PainterStateCubit painterStateCubit;

  const Painter({super.key, required this.painterStateCubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        painterStateCubit.startNewPath(point);
      },
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        painterStateCubit.updatePainter(point);
      },
      onPanEnd: (details) {
        painterStateCubit.endPath();
      },
      child: BlocBuilder<PainterStateCubit, PainterState>(
        bloc: painterStateCubit,
        builder: (context, state) => RepaintBoundary(
          child: Container(
              color: Colors.amber[50],
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: state.painter,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ColorPalette(colors: const [
                            Colors.black,
                            Colors.red,
                            Colors.orange,
                            Colors.green,
                            Colors.blue,
                          ], painterStateCubit: painterStateCubit),
                          EraseButton(painterStateCubit: painterStateCubit),
                          SaveButton(painterStateCubit: painterStateCubit, parentContext: context,)
                        ],
                      ),
                      StrokeWidthButtonList(
                        painterStateCubit: painterStateCubit,
                        strokeWidthList: StrokeWidthType.values,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
