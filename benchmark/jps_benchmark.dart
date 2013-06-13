library pathfinding.jps_benchmark;

import 'package:pathfinding/finders/jps.dart';

import 'benchmark_base.dart';

const int GRID_WIDTH = 100;
const int GRID_HEIGHT = 100;

class JumpPointFinderBenchmark extends PathfindingBenchmarkBase {
  JumpPointFinderBenchmark() : super("JumpPointFinder", new JumpPointFinder());

  static void main() {
    new JumpPointFinderBenchmark().report();
  }
}

main() {
  JumpPointFinderBenchmark.main();
}