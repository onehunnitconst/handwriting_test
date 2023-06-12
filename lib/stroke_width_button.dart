import 'package:flutter/material.dart';

class StrokeWidthButton extends StatelessWidget {
  final Color color;
  final double width;
  final void Function()? onTap;

  const StrokeWidthButton(
      {super.key, required this.width, this.onTap, required this.color});

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: const Color(0x11000000),
                  offset: Offset.fromDirection(45.0, 2.0),
                  spreadRadius: 3.0,
                  blurRadius: 3.0)
            ],
          ),
          width: width,
          height: width,
          child: Container(),
        ),
      ),
    );
  }
}