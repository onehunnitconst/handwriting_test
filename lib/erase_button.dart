import 'package:flutter/material.dart';
import 'package:handwriting_test/painter_state_cubit.dart';

class EraseButton extends StatelessWidget {
  final PainterStateCubit painterStateCubit;

  const EraseButton({super.key, required this.painterStateCubit});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        painterStateCubit.clear();
      },
      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white60)),
      child: const Text("지우기", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
    );
  }
}
