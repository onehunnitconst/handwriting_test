import 'package:flutter/material.dart';
import 'package:handwriting_test/painter_state_cubit.dart';

class SaveButton extends StatelessWidget {
  final BuildContext parentContext;
  final PainterStateCubit painterStateCubit;

  const SaveButton({super.key, required this.painterStateCubit, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        painterStateCubit.state.saveImage(parentContext);
      },
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white60)),
      child: const Text("저장",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
    );
  }
}
