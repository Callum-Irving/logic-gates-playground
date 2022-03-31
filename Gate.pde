abstract class Gate {
  int x, y;
  boolean output = false;

  abstract void show();
  // Returns true if the mouse is colliding with the gate
  abstract boolean mouseOver();
  abstract boolean mouseOverOutput();
  // Returns -1 if false
  abstract int mouseOverInput();
  abstract PVector inputPos(int inputNum);
  abstract PVector outputPos();

  void showConnections() {
    for (Connection c : this.connections) {
      c.show();
    }
  }

  int numInputs;
  ArrayList<Connection> connections;
  Gate[] inputs;
  abstract boolean _compute(boolean[] inputs);

  boolean compute(boolean[] inputs) {
    assert(inputs.length == this.numInputs);
    this.output = _compute(inputs);
    return this.output;
  }

  void addConnection(String srcId, String destId, Gate dest, int inputNum) {
    this.connections.add(new Connection(srcId, this, destId, dest, inputNum));
    dest.inputs[inputNum] = this;
  }

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

  Gate(int n) {
    this.numInputs = n;
    this.connections = new ArrayList<Connection>();
    this.inputs = new Gate[n];
    this.x = int(random(width));
    this.y = int(random(height));
  }
}
