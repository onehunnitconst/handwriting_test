import 'package:flutter/material.dart';
import 'package:handwriting_test/color_palette.dart';
import 'package:handwriting_test/painter.dart';
import 'package:handwriting_test/painter_state_cubit.dart';
import 'package:handwriting_test/stroke_width_list.dart';
import 'package:handwriting_test/stroke_width_type.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider<PainterStateCubit>(create: (context) => PainterStateCubit())
    ], child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Handwriting Test App')),
        body: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PainterStateCubit painterStateCubit =
        Provider.of<PainterStateCubit>(context);

    return Painter(painterStateCubit: painterStateCubit);
  }
}
