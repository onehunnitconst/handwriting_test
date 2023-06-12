import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  final void Function()? onTap;

  const ColorButton({super.key, required this.color, this.onTap});

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: color, boxShadow: _boxShadow),
          width: 50,
          height: 50,
          child: Container(),
        ),
      ),
    );
  }

  List<BoxShadow> get _boxShadow => [
        BoxShadow(
            color: const Color(0x11000000),
            offset: Offset.fromDirection(45.0, 2.0),
            spreadRadius: 3.0,
            blurRadius: 3.0)
      ];
}
