import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handwriting_test/painter_state.dart';
import 'package:handwriting_test/painter_state_cubit.dart';
import 'package:handwriting_test/stroke_width_button.dart';
import 'package:handwriting_test/stroke_width_type.dart';

class StrokeWidthButtonList extends StatelessWidget {
  final List<StrokeWidthType> strokeWidthList;
  final PainterStateCubit painterStateCubit;

  const StrokeWidthButtonList(
      {Key? key,
      required this.painterStateCubit,
      required this.strokeWidthList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<PainterStateCubit, PainterState>(
        bloc: painterStateCubit,
        builder: (context, state) => Container(
          color: const Color(0x22FFFFFF),
          child: Row(children: strokeWidthList.map(_renderButton(state.selectedColor)).toList()),
        ),
      ),
    );
  }

  StrokeWidthButton Function(StrokeWidthType) _renderButton(
          Color currentColor) =>
      (StrokeWidthType strokeWidthType) => StrokeWidthButton(
            color: currentColor,
            width: strokeWidthType.width,
            onTap: () {
              painterStateCubit.changeSelectedStrokeWidth(strokeWidthType);
            },
          );
}
