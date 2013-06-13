PathFinding.dart
================

A Dart port of https://github.com/qiao/PathFinding.js library

Installing
----------

http://pub.dartlang.org/packages/pathfinding#installing

Usage:
------

```dart
import 'package:pathfinding/finders/jps.dart';
import 'package:pathfinding/core/grid.dart';

main() {
  var grid = new Grid(4, 4, [
    [0, 0, 1, 1], // 0 - walkable, 1 - not walkable
    [1, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 0, 0]
  ]);
  var jps = new JumpPointFinder();
  var path = jps.findPath(0, 0, 3, 3, grid);
  print(path); // [[0, 0], [1, 1], [1, 2], [2, 3], [3, 3]]
}
```

Available finders:
------------------
 - AStar
 - JumpPointFinder

TODO:

 - BreadthFirst
 - Dijkstra
 - BiBreadthFirst
 - BiDijkstra
 - BiAStarFinder
 - BestFirstFinder
 - BiBestFirstFinder

Benchmarks
----------

Dart SDK version 0.5.16.0_r23799
 
Dartium
```
AStarFinder(RunTime): 146642.85714285713 us.
JumpPointFinder(RunTime): 38301.88679245283 us. 
```

dart2js
```
AStarFinder(RunTime): 265750 us. 
JumpPointFinder(RunTime): 105631.57894736843 us.
```
