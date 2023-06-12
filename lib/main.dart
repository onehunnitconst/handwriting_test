import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late MyCustomPainter _painter;
  late PathOffset _current;
  late Color _selectedColor;
  late double _strokeWidth;
  late List<PathOffset> _paths;

  @override
  void initState() {
    super.initState();
    _painter = MyCustomPainter((canvas, size) {});
    _current = PathOffset.zero;
    _paths = [];
    _selectedColor = Colors.black;
    _strokeWidth = 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        setState(() {
          Paint paint = Paint();
          paint.style = PaintingStyle.stroke;
          paint.color = _selectedColor;
          paint.strokeWidth = _strokeWidth;
          paint.strokeCap = StrokeCap.round;
          _current = PathOffset(point, paint: paint);
        });
      },
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        setState(() {
          _current.addPoint(point);
          _painter = MyCustomPainter((canvas, size) {
            for (final path in _paths) {
              path.drawPath(canvas);
            }
            _current.drawPath(canvas);
          });
        });
      },
      onPanEnd: (details) {
        _paths.add(_current);
      },
      child: RepaintBoundary(
        child: Container(
          color: Colors.amber[50],
          child: Stack(
            children: [
              CustomPaint(
                painter: _painter,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ColorButton(
                        color: Colors.black,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.black;
                          });
                        },
                      ),
                      ColorButton(
                        color: Colors.red,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.red;
                          });
                        },
                      ),
                      ColorButton(
                        color: Colors.blue,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.blue;
                          });
                        },
                      ),
                      ColorButton(
                        color: Colors.green,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.green;
                          });
                        },
                      ),
                      ColorButton(
                        color: Colors.orange,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.orange;
                          });
                        },
                      ),
                      ColorButton(
                        color: Colors.white,
                        onTap: () {
                          setState(() {
                            _selectedColor = Colors.white;
                          });
                        },
                      ),
                    ],
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Row(
                      children: [
                        StrokeButton(
                          width: 5.0,
                          color: _selectedColor,
                          onTap: () {
                            setState(() {
                              _strokeWidth = 5.0;
                            });
                          },
                        ),
                        StrokeButton(
                          width: 10.0,
                          color: _selectedColor,
                          onTap: () {
                            setState(() {
                              _strokeWidth = 10.0;
                            });
                          },
                        ),
                        StrokeButton(
                          width: 15.0,
                          color: _selectedColor,
                          onTap: () {
                            setState(() {
                              _strokeWidth = 15.0;
                            });
                          },
                        ),
                        TextButton(
                            onPressed: () {
                              _painter = MyCustomPainter((canvas, size) {});
                              _current = PathOffset.zero;
                              _paths = [];
                            },
                            child: const Text("erase"))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final void Function(Canvas, Size) repaint;

  MyCustomPainter(this.repaint);

  @override
  void paint(Canvas canvas, Size size) {
    repaint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PathOffset {
  late final Offset _startPoint;
  late final List<Offset> _points;
  late final Paint _paint;

  PathOffset(Offset offset, {Paint? paint}) {
    _startPoint = offset;
    _points = [];
    _paint = paint ?? _defaultPaint;
  }

  static get zero {
    return PathOffset(Offset.zero);
  }

  Paint get _defaultPaint {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  void addPoint(Offset point) {
    _points.add(point);
  }

  void setColor(Color color) {
    _paint.color = color;
  }

  void drawPath(Canvas canvas) {
    Path path = Path();

    path.moveTo(_startPoint.dx, _startPoint.dy);
    for (final point in _points) {
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, _paint);
  }
}

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
          decoration: BoxDecoration(color: color, boxShadow: [
            BoxShadow(
                color: Color(0x11000000),
                offset: Offset.fromDirection(45.0, 2.0),
                spreadRadius: 3.0,
                blurRadius: 3.0)
          ]),
          width: 50,
          height: 50,
          child: Container(),
        ),
      ),
    );
  }
}

class StrokeButton extends StatelessWidget {
  final Color color;
  final double width;
  final void Function()? onTap;

  const StrokeButton(
      {super.key, required this.width, this.onTap, required this.color});

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Color(0x11000000),
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
