import 'package:flutter/material.dart';
import 'package:handwriting_test/color_button.dart';
import 'package:handwriting_test/painter_state_cubit.dart';

class ColorPalette extends StatelessWidget {
  final List<Color> colors;
  final PainterStateCubit painterStateCubit;

  const ColorPalette({Key? key, required this.colors, required this.painterStateCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: const Color(0x22FFFFFF),
        child: Row(
            children: colors
                .map(_renderButton)
                .toList()),
      ),
    );
  }

  ColorButton _renderButton(Color color) {
    return ColorButton(
      color: color,
      onTap: () {
        painterStateCubit.changeSelectedColor(color);
      },
    );
  }
}
