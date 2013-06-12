
import 'package:pathfinding/core/grid.dart';
import 'test_util.dart';

main() {
  describe('Grid', () {
      describe('generate without matrix', () {
          var width, height, grid;

          setUp(() {
              width = 10;
              height = 20;
              grid = new Grid(width, height);
          });

          it('should have correct size', () {
              expect(grid.width, width);
              expect(grid.height, height);

              expect(grid.nodes.length, height);
              for (var i = 0; i < height; ++i) {
                  expect(grid.nodes[i].length, width);
              }
          });

          it('should set all nodes\' walkable attribute', () {
              for (var i = 0; i < height; ++i) {
                  for (var j = 0; j < width; ++j) {
                      expect(grid.isWalkableAt(j, i), isTrue);
                  }
              }
          });
      });

      describe('generate with matrix', () {
          var matrix, grid, width, height;

          enumPos(Function f, [o]) {
              for (var y = 0; y < height; ++y) {
                  for (var x = 0; x < width; ++x) {
                      if (o != null) {
                          f(o, x, y, grid);
                      } else {
                          f(x, y, grid);
                      }
                  }
              }
          }

          setUp(() {
              matrix = [
                  [1, 0, 0, 1],
                  [0, 1, 0, 0],
                  [0, 1, 0, 0],
                  [0, 0, 0, 0],
                  [1, 0, 0, 1],
              ];
              height = matrix.length;
              width = matrix[0].length;
              grid = new Grid(width, height, matrix);
          });

          it('should have correct size', () {
              expect(grid.width, width);
              expect(grid.height, height);

              expect(grid.nodes.length, height);
              for (var i = 0; i < height; ++i) {
                  expect(grid.nodes[i].length, width);
              }
          });

          it('should initiate all nodes\' walkable attribute', () {
              enumPos((x, y, o) {
                  if (matrix[y][x] == true || matrix[y][x] == 1) {
                      expect(grid.isWalkableAt(x, y), isFalse);
                  } else {
                      expect(grid.isWalkableAt(x, y), isTrue);
                  }
              });
          });

          it('should be able to set nodes\' walkable attribute', () {
              enumPos((x, y, o) {
                  grid.setWalkableAt(x, y, false);
              });
              enumPos((x, y, o) {
                  expect(grid.isWalkableAt(x, y), isFalse);
              });
              enumPos((x, y, o) {
                  grid.setWalkableAt(x, y, true);
              });
              enumPos((x, y, o) {
                  expect(grid.isWalkableAt(x, y), isTrue);
              });
          });

          it('should return correct answer for position validity query', () {
              var asserts = [
                  [0, 0, true],
                  [0, height - 1, true],
                  [width - 1, 0, true],
                  [width - 1, height - 1, true],
                  [-1, -1, false],
                  [0, -1, false],
                  [-1, 0, false],
                  [0, height, false],
                  [width, 0, false],
                  [width, height, false],
              ];

              asserts.forEach((v) {
                  expect(grid.isInside(v[0], v[1]), v[2]);
              });
          });

          it('should return correct neighbors', () {
              expect(grid.getNeighbors(grid.nodes[1][0], true), [ grid.nodes[2][0] ]);
              cmp(a, b) {
                  return a.x * 100 + a.y - b.x * 100 - b.y;
              };
              expect(grid.getNeighbors(grid.nodes[0][2], true).sort(cmp), [
                  grid.nodes[0][1], grid.nodes[1][2], grid.nodes[1][3]
              ].sort(cmp));
          });
      });
  });
}