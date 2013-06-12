import 'package:pathfinding/finders/jps.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:pathfinding/core/grid.dart';

main() {
  var grid = new Grid(4, 4, [
    [0, 0, 1, 1], // 0 - walkable, 1 - not walkable
    [1, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 0, 0]
  ]);
  var path = new JumpPointFinder().findPath(0, 0, 3, 3, grid.clone());
  print(path); // [[0, 0], [1, 1], [1, 2], [2, 3], [3, 3]]

  path = new AStarFinder().findPath(0, 0, 3, 3, grid.clone());
  print(path); // [[0, 0], [1, 0], [1, 1], [1, 2], [1, 3], [2, 3], [3, 3]]
}