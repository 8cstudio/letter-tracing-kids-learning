import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/shape_enums.dart';
import '../manager/tracing_cubit.dart';
import '../model/trace_geometric_shape_model.dart';
import '../phonetics_paint_widget/phonetics_painter.dart';

class TracingGeometricShapesGame extends StatefulWidget {
  const TracingGeometricShapesGame({
    super.key,
    required this.traceGeoMetricShapeModels,
    this.loadingIndictor = const CircularProgressIndicator(),
    this.showAnchor = true,
    this.onTracingUpdated,
    this.onGameFinished,
    this.onCurrentTracingScreenFinished,
  });
  final List<TraceGeoMetricShapeModel> traceGeoMetricShapeModels;
  final Widget loadingIndictor;
  final bool showAnchor;

  final Future<void> Function(int index)? onTracingUpdated;
  final Future<void> Function(int index)? onGameFinished;
  final Future<void> Function(int index)? onCurrentTracingScreenFinished;

  @override
  State<StatefulWidget> createState() => _TracingGeometricShapesGameState();
}

class _TracingGeometricShapesGameState
    extends State<TracingGeometricShapesGame> {
  late TracingCubit tracingCubit;

  @override
  void initState() {
    super.initState();
    tracingCubit = TracingCubit(
      stateOfTracing: StateOfTracing.traceShapes,
      traceGeoMetricShapeModel: widget.traceGeoMetricShapeModels,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => tracingCubit,
      child: BlocConsumer<TracingCubit, TracingState>(
        listener: (context, stateOfGame) async {
          if (stateOfGame.drawingStates == DrawingStates.tracing) {
            if (widget.onTracingUpdated != null) {
              await widget.onTracingUpdated!(stateOfGame.activeIndex);
            }
          } else if (stateOfGame.drawingStates ==
              DrawingStates.finishedCurrentScreen) {
            if (widget.onCurrentTracingScreenFinished != null) {
              await widget.onCurrentTracingScreenFinished!(
                stateOfGame.index + 1,
              );
            }
            if (context.mounted) {
              tracingCubit.updateIndex();
            }
          } else if (stateOfGame.drawingStates == DrawingStates.gameFinished) {
            if (widget.onGameFinished != null) {
              await widget.onGameFinished!(stateOfGame.index);
            }
          }
        },
        builder: (context, state) {
          if (widget.traceGeoMetricShapeModels.isEmpty) {
            return const SizedBox();
          }
          if (state.drawingStates == DrawingStates.loading ||
              state.drawingStates == DrawingStates.initial) {
            return widget.loadingIndictor;
          }

          if (state.letterPathsModels.isEmpty) {
            return const SizedBox();
          }

          return FittedBox(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.end
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(state.letterPathsModels.length, (
                  index,
                ) {
                  return FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      padding: EdgeInsets.only(
                        right:
                            index < state.letterPathsModels.length - 1 ? 50 : 0,
                      ),
                      child: GestureDetector(
                        onPanStart: (details) {
                          if (index == state.activeIndex) {
                            tracingCubit.handlePanStart(details.localPosition);
                          }
                        },
                        onPanUpdate: (details) {
                          if (index == state.activeIndex) {
                            tracingCubit.handlePanUpdate(details.localPosition);
                          }
                        },
                        onPanEnd: (details) {},
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CustomPaint(
                              size: tracingCubit.viewSize,
                              painter: PhoneticsPainter(
                                strokeIndex:
                                    state.letterPathsModels[index].strokeIndex,
                                indexPath:
                                    state.letterPathsModels[index].letterIndex,
                                dottedPath:
                                    state.letterPathsModels[index].dottedIndex,
                                letterColor:
                                    state
                                        .letterPathsModels[index]
                                        .outerPaintColor,
                                letterImage:
                                    state.letterPathsModels[index].letterImage!,
                                paths: state.letterPathsModels[index].paths,
                                currentDrawingPath:
                                    state
                                        .letterPathsModels[index]
                                        .currentDrawingPath,
                                pathPoints:
                                    state
                                        .letterPathsModels[index]
                                        .allStrokePoints
                                        .expand((p) => p)
                                        .toList(),
                                strokeColor:
                                    state
                                        .letterPathsModels[index]
                                        .innerPaintColor,
                                viewSize:
                                    state.letterPathsModels[index].viewSize,
                                strokePoints:
                                    state
                                        .letterPathsModels[index]
                                        .allStrokePoints[state
                                        .letterPathsModels[index]
                                        .currentStroke],
                                strokeWidth:
                                    state.letterPathsModels[index].strokeWidth,
                                dottedColor:
                                    state.letterPathsModels[index].dottedColor,
                                indexColor:
                                    state.letterPathsModels[index].indexColor,
                                indexPathPaintStyle:
                                    state
                                        .letterPathsModels[index]
                                        .indexPathPaintStyle,
                                dottedPathPaintStyle:
                                    state
                                        .letterPathsModels[index]
                                        .dottedPathPaintStyle,
                              ),
                            ),
                            if (state.activeIndex == index && widget.showAnchor)
                              Positioned(
                                top:
                                    state
                                        .letterPathsModels[state.activeIndex]
                                        .anchorPos!
                                        .dy,
                                left:
                                    state
                                        .letterPathsModels[state.activeIndex]
                                        .anchorPos!
                                        .dx,
                                child: Image.asset(
                                  'lib/lib2/assets/images/marker.png',
                                  height: 50,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
