library pathfinding.benchmark_base;

import 'dart:math';

import 'package:pathfinding/core/grid.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

class PathfindingBenchmarkBase extends BenchmarkBase {
  List<Grid> grids = <Grid>[];
  var finder;

  PathfindingBenchmarkBase(name, this.finder) : super(name);

  // Not measured setup code executed prior to the benchmark runs.
  void setup() {
    grids.add(generateGrid(100, 100));
    grids.add(generateGrid(50, 50));
    grids.add(generateGrid(10, 100));
    grids.add(generateGrid(100, 10));
    grids.add(generateUnwalkableGrid(100, 100));
    grids.add(generateUnwalkableGrid(50, 50));
    grids.add(generateUnwalkableGrid(10, 100));
    grids.add(generateUnwalkableGrid(100, 10));
    grids.add(generateGrid2());
  }

  Grid generateGrid(int width, int height) {
    Grid grid = new Grid(width, height);
    for (int i = 1; i < width; i++) {
      grid.getNodeAt(i, height ~/ 2).walkable = false;
    }
    for (int i = 0; i < height - 1; i++) {
      grid.getNodeAt(width ~/ 2, i).walkable = false;
    }
    return grid;
  }

  Grid generateUnwalkableGrid(int width, int height) {
    Grid grid = new Grid(width, height);
    for (int i = 1; i < width; i++) {
      grid.getNodeAt(i, height ~/ 2).walkable = false;
    }
    for (int i = 0; i < height; i++) {
      grid.getNodeAt(width ~/ 2, i).walkable = false;
    }
    return grid;
  }

  Grid generateGrid2() {
    return new Grid(10, 10, [
      [0, 1, 0, 1, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 1, 0, 1],
      [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
      [0, 1, 0, 1, 0, 0, 0, 1, 1, 0],
      [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
      [0, 1, 0, 1, 0, 1, 1, 1, 0, 1],
      [0, 1, 0, 0, 0, 1, 0, 1, 0, 0],
      [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 1, 0, 0]
    ]);
  }

  // The benchmark code.
  void run() {
    for (var grid in grids) {
      finder.findPath(0, 0, grid.width - 1, grid.height - 1, grid.clone());
    }
  }

}
