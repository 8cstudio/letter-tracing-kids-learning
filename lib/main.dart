import 'package:flutter/material.dart';
import 'package:patterens/lib2/src/enums/shape_enums.dart';
import 'package:patterens/lib2/src/tracing/model/trace_geometric_shape_model.dart';
import 'package:patterens/lib2/src/tracing/model/trace_shape_model.dart';
import 'package:patterens/lib2/src/tracing/model/trace_shape_options.dart';
import 'package:patterens/lib2/src/tracing/model/trace_word_model.dart';
import 'package:patterens/lib2/src/tracing/page/trace_shapes_game.dart';
import 'package:patterens/lib2/src/tracing/page/tracing_chars_game.dart';
import 'package:patterens/lib2/src/tracing/page/tracing_word_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tracing Game')),
        body: Column(
          // spacing: 3,
          children: [
            Expanded(
              child: TracingCharsGame(
                showAnchor: true,
                traceShapeModel: [
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'X',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                      TraceCharModel(
                        char: 'r',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                      TraceCharModel(
                        char: '2',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],

                onTracingUpdated: (int currentTracingIndex) async {
                  print(
                    '/////onTracingUpdated:' + currentTracingIndex.toString(),
                  );
                },
                onGameFinished: (int screenIndex) async {
                  print('/////onGameFinished:' + screenIndex.toString());
                },
                onCurrentTracingScreenFinished: (int currentScreenIndex) async {
                  print(
                    '/////onCurrentTracingScreenFinished:' +
                        currentScreenIndex.toString(),
                  );
                },
              ),
            ),
            // Expanded(
            //   child: TracingGeometricShapesGame(
            //     traceGeoMetricShapeModels: [
            //       TraceGeoMetricShapeModel(
            //         shapes: [
            //           MathShapeWithOption(
            //             shape: MathShapes.circle,
            //             traceShapeOptions: const TraceShapeOptions(
            //               innerPaintColor: Colors.orange,
            //             ),
            //           ),
            //           MathShapeWithOption(
            //             shape: MathShapes.triangle1,
            //             traceShapeOptions: const TraceShapeOptions(
            //               innerPaintColor: Colors.orange,
            //             ),
            //           ),
            //         ],
            //       ),
            //       TraceGeoMetricShapeModel(
            //         shapes: [
            //           MathShapeWithOption(
            //             shape: MathShapes.triangle3,
            //             traceShapeOptions: const TraceShapeOptions(
            //               innerPaintColor: Colors.orange,
            //             ),
            //           ),
            //           MathShapeWithOption(
            //             shape: MathShapes.triangle2,
            //             traceShapeOptions: const TraceShapeOptions(
            //               innerPaintColor: Colors.orange,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: SizedBox(
                height: 200,
                width: 200,
                child: TracingWordGame(
                  words: [
                    TraceWordModel(
                      word: 'A',
                      traceShapeOptions: const TraceShapeOptions(
                        indexColor: Colors.green,
                      ),
                    ),
                  ],
                  onTracingUpdated: (int currentTracingIndex) async {
                    print(
                      '/////onTracingUpdated:' + currentTracingIndex.toString(),
                    );
                  },
                  onGameFinished: (int screenIndex) async {
                    print('/////onGameFinished:' + screenIndex.toString());
                  },
                  onCurrentTracingScreenFinished: (
                    int currentScreenIndex,
                  ) async {
                    print(
                      '/////onCurrentTracingScreenFinished:' +
                          currentScreenIndex.toString(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
