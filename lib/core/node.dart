library pathfinding.core.node;

/**
 * A node in grid.
 * This class holds some basic information about a node and custom
 * attributes may be added, depending on the algorithms' needs.
 * @constructor
 * @param {number} x - The x coordinate of the node on the grid.
 * @param {number} y - The y coordinate of the node on the grid.
 * @param {boolean} [walkable] - Whether this node is walkable.
 */
class Node {
  /**
   * The x coordinate of the node on the grid.
   * @type number
   */
  int x;

  /**
   * The y coordinate of the node on the grid.
   * @type number
   */
  int y;

  /**
   * Whether this node can be walked through.
   * @type boolean
   */
  bool walkable;

  // TODO: this is a hack...
  num g, h, f;
  bool opened, closed;
  Node parent;

  Node(this.x, this.y, [walkable]) {
    this.walkable = (walkable == null ? true : walkable);
  }

  String toString() => 'Node[$x,$y]';
}
