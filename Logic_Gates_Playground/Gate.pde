abstract class Gate {
  int x, y;
  boolean output = false;

  int numInputs;
  ArrayList<Connection> connections;

  // This stores all of the gates that connect to the inputs of this gate. This
  // is useful when we need to delete incoming connections of a gate.
  Gate[] inputs;

  // This constructor is meant to be used when users are creating and using
  // nodes just from the API (not visually). Since they are not being displayed,
  // x and y don't matter.
  Gate(int n) {
    this(n, 0, 0);
  }

  Gate(int n, int x, int y) {
    this.numInputs = n;
    this.connections = new ArrayList<Connection>();
    this.inputs = new Gate[n];
    this.x = x;
    this.y = y;
  }

  // Subclasses implement this to draw the gate and lines connecting inputs and
  // outputs.
  abstract void _show();

  // Returns the output given inputs.
  abstract boolean _compute(boolean[] inputs);

  // Returns the position of input number inputNum in world space.
  abstract PVector inputPos(int inputNum);

  // Return the position of the output in world space.
  abstract PVector outputPos();

  // Checks if a point in world space is touching the gate.
  // Used for moving and deleting gates
  abstract boolean pointTouching(float x, float y);

  // This can be override by subclasses to define functionality when the gate
  // is clicked.
  void clicked() {
  }

  // This first determines that the right number of inputs have been passed to
  // the gate then calls the _compute() function defined by the subclass.
  boolean compute(boolean[] inputs) {
    assert(inputs.length == this.numInputs);
    this.output = _compute(inputs);
    return this.output;
  }

  // This calls _show() defined by the subclass and then draws the inputs and
  // outputs on top.
  void show() {
    this._show();
    stroke(0);
    fill(250);
    strokeWeight(1);

    for (int i = 0; i < this.numInputs; i++) {
      circle(this.inputPos(i).x, this.inputPos(i).y, 12);
    }
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  // Draw all the outgoing connections of a gate.
  void showConnections() {
    for (Connection c : this.connections) {
      c.show();
    }
  }

  // Adds a connection object to this gate's list of connections.
  void addConnection(String srcId, String destId, Gate dest, int inputNum) {
    this.connections.add(new Connection(srcId, this, destId, dest, inputNum));
    dest.inputs[inputNum] = this;
  }

  // Removes an incoming connection.
  void removeInput(int inputNum) {
    if (this.inputs[inputNum] != null) {
      Gate src = this.inputs[inputNum];
      for (int i = 0; i < src.connections.size(); i++) {
        if (src.connections.get(i).dest == this) {
          src.connections.remove(i);
          this.inputs[inputNum] = null;
          return;
        }
      }
    }
  }

  // Checks if a point is over an input of the gate. If it is, it returns the
  // input number. If it isn't, it returns -1.
  int overInput(float x, float y) {
    for (int i = 0; i < this.numInputs; i++) {
      if (distance(x, y, this.inputPos(i).x, this.inputPos(i).y) < 6)
        return i;
    }
    return -1;
  }

  // Checks if a point is over the output of a gate.
  boolean overOutput(float x, float y) {
    return (distance(x, y, this.outputPos().x, this.outputPos().y) < 6);
  }
}
