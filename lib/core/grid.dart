library pathfinding.core.grid;

import 'node.dart';

/**
 * The Grid class, which serves as the encapsulation of the layout of the nodes.
 * @constructor
 * @param {number} width Number of columns of the grid.
 * @param {number} height Number of rows of the grid.
 * @param {Array.<Array.<(number|boolean)>>} [matrix] - A 0-1 matrix
 *     representing the walkable status of the nodes(0 or false for walkable).
 *     If the matrix is not supplied, all the nodes will be walkable.  */
class Grid {
  late int width;
  late int height;
  late var nodes;

  Grid(width, height, [matrix]) {
    /**
     * The number of columns of the grid.
     * @type number
     */
    this.width = width;
    /**
     * The number of rows of the grid.
     * @type number
     */
    this.height = height;

    /**
     * A 2D array of nodes.
     */
    this.nodes = _buildNodes(width, height, matrix);
  }

  /**
   * Build and return the nodes.
   * @private
   * @param {number} width
   * @param {number} height
   * @param {Array.<Array.<number|boolean>>} [matrix] - A 0-1 matrix representing
   *     the walkable status of the nodes.
   * @see Grid
   */
  _buildNodes(width, height, matrix) {
    var i, j,
    nodes = new List.filled(height, new List<Node?>.filled(width, null)),
    row;

    for (i = 0; i < height; ++i) {
      nodes[i] = new List.filled(width, null);
      for (j = 0; j < width; ++j) {
        nodes[i][j] = new Node(j, i);
        nodes[i][j]!.walkable = true;
      }
    }


    if (matrix == null) {
      return nodes;
    }

    if (matrix.length != height || matrix[0].length != width) {
      throw new Exception('Matrix size does not fit');
    }

    for (i = 0; i < height; ++i) {
      for (j = 0; j < width; ++j) {
        if (matrix[i][j] == true || matrix[i][j] == 1) {
          // 0, false, null will be walkable
          // while others will be un-walkable
          nodes[i][j]!.walkable = false;
        }
      }
    }

    return nodes;
  }


  Node getNodeAt(x, y) {
    return this.nodes[y][x];
  }


  /**
   * Determine whether the node at the given position is walkable.
   * (Also returns false if the position is outside the grid.)
   * @param {number} x - The x coordinate of the node.
   * @param {number} y - The y coordinate of the node.
   * @return {boolean} - The walkability of the node.
   */
  bool isWalkableAt(x, y) {
    return this.isInside(x, y) && this.nodes[y][x].walkable;
  }


  /**
   * Determine whether the position is inside the grid.
   * XXX: `grid.isInside(x, y)` is wierd to read.
   * It should be `(x, y) is inside grid`, but I failed to find a better
   * name for this method.
   * @param {number} x
   * @param {number} y
   * @return {boolean}
   */
  bool isInside(x, y) {
    return (x >= 0 && x < this.width) && (y >= 0 && y < this.height);
  }


  /**
   * Set whether the node on the given position is walkable.
   * NOTE: throws exception if the coordinate is not inside the grid.
   * @param {number} x - The x coordinate of the node.
   * @param {number} y - The y coordinate of the node.
   * @param {boolean} walkable - Whether the position is walkable.
   */
  setWalkableAt(x, y, walkable) {
    this.nodes[y][x].walkable = walkable;
  }


  /**
   * Get the neighbors of the given node.
   *
   *     offsets      diagonalOffsets:
   *  +---+---+---+    +---+---+---+
   *  |   | 0 |   |    | 0 |   | 1 |
   *  +---+---+---+    +---+---+---+
   *  | 3 |   | 1 |    |   |   |   |
   *  +---+---+---+    +---+---+---+
   *  |   | 2 |   |    | 3 |   | 2 |
   *  +---+---+---+    +---+---+---+
   *
   *  When allowDiagonal is true, if offsets[i] is valid, then
   *  diagonalOffsets[i] and
   *  diagonalOffsets[(i + 1) % 4] is valid.
   * @param {Node} node
   * @param {boolean} allowDiagonal
   * @param {boolean} dontCrossCorners
   */
  getNeighbors(node, allowDiagonal, [dontCrossCorners = false]) {
    var x = node.x,
        y = node.y,
        neighbors = [],
        s0 = false, d0 = false,
        s1 = false, d1 = false,
        s2 = false, d2 = false,
        s3 = false, d3 = false,
        nodes = this.nodes;

    // ↑
    if (this.isWalkableAt(x, y - 1)) {
      neighbors.add(nodes[y - 1][x]);
      s0 = true;
    }
    // →
    if (this.isWalkableAt(x + 1, y)) {
      neighbors.add(nodes[y][x + 1]);
      s1 = true;
    }
    // ↓
    if (this.isWalkableAt(x, y + 1)) {
      neighbors.add(nodes[y + 1][x]);
      s2 = true;
    }
    // ←
    if (this.isWalkableAt(x - 1, y)) {
      neighbors.add(nodes[y][x - 1]);
      s3 = true;
    }

    if (!allowDiagonal) {
      return neighbors;
    }

    if (dontCrossCorners) {
      d0 = s3 && s0;
      d1 = s0 && s1;
      d2 = s1 && s2;
      d3 = s2 && s3;
    } else {
      d0 = s3 || s0;
      d1 = s0 || s1;
      d2 = s1 || s2;
      d3 = s2 || s3;
    }

    // ↖
    if (d0 && this.isWalkableAt(x - 1, y - 1)) {
      neighbors.add(nodes[y - 1][x - 1]);
    }
    // ↗
    if (d1 && this.isWalkableAt(x + 1, y - 1)) {
      neighbors.add(nodes[y - 1][x + 1]);
    }
    // ↘
    if (d2 && this.isWalkableAt(x + 1, y + 1)) {
      neighbors.add(nodes[y + 1][x + 1]);
    }
    // ↙
    if (d3 && this.isWalkableAt(x - 1, y + 1)) {
      neighbors.add(nodes[y + 1][x - 1]);
    }

    return neighbors;
  }


  /**
   * Get a clone of this grid.
   * @return {Grid} Cloned grid.
   */
  clone() {
    var i, j,

    width = this.width,
    height = this.height,
    thisNodes = this.nodes,

    newGrid = new Grid(width, height),
    newNodes = new List.filled(height, new List<Node?>.filled(width, null)),
    row;

    for (i = 0; i < height; ++i) {
      newNodes[i] = new List.filled(width, null);
      for (j = 0; j < width; ++j) {
        newNodes[i][j] = new Node(j, i, thisNodes[i][j].walkable);
      }
    }

    newGrid.nodes = newNodes;

    return newGrid;
  }
}

