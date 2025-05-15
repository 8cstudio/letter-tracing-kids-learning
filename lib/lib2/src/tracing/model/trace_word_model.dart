import 'trace_shape_options.dart';

class TraceWordModel {
  final String word;
  final TraceShapeOptions traceShapeOptions;
  TraceWordModel({
    required this.word,
    this.traceShapeOptions = const TraceShapeOptions(),
  });
}
