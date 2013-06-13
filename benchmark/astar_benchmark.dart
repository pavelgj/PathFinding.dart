library pathfinding.astar_benchmark;

import 'package:pathfinding/finders/astar.dart';

import 'benchmark_base.dart';

class AStarFinderBenchmark extends PathfindingBenchmarkBase {
  AStarFinderBenchmark() : super("AStarFinder", new AStarFinder());

  static void main() {
    new AStarFinderBenchmark().report();
  }
}

main() {
  AStarFinderBenchmark.main();
}