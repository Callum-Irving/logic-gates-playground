abstract class Gate {
  int x, y;
  String name;

  abstract void _show();
  // Returns true if the mouse is colliding with the gate
  abstract boolean mouseOver();
  abstract PVector inputPos(int inputNum);
  abstract PVector outputPos();

  void show() {
    this._show();
    for (Connection c : this.connections) {
      c.show();
    }
  }

  int numInputs;
  ArrayList<Connection> connections;
  abstract boolean _compute(boolean[] inputs);

  boolean compute(boolean[] inputs) {
    assert(inputs.length == this.numInputs);
    return _compute(inputs);
  }

  void addConnection(String srcId, String destId, Gate dest, int inputNum) {
    this.connections.add(new Connection(srcId, this, destId, dest, inputNum));
  }

  Gate(int n, String name) {
    this.numInputs = n;
    this.name = name;
    this.connections = new ArrayList<Connection>();
    this.x = int(random(width));
    this.y = int(random(height));
  }
}

class InputGate extends Gate {
  boolean output = false;

  InputGate() {
    super(0, "INPUT");
  }

  void setVal(boolean val) {
    this.output = val;
  }

  boolean _compute(boolean[] inputs) {
    return this.output;
  }

  void _show() {
    noStroke();
    fill(60);
    circle(this.x, this.y, 20);
    if (this.output)
      fill(235, 235, 52);
    else
      fill(0);
    circle(this.x, this.y, 15);
  }

  boolean mouseOver() {
    return (sqrt(pow(mouseX - this.x, 2) + pow(mouseY - this.y, 2)) < 10);
  }

  // Inputs don't take inputs so this should never be called
  PVector inputPos(int _) {
    assert(true == false);
    return null;
  }

  PVector outputPos() {
    return new PVector(this.x, this.y);
  }
}

class OutputGate extends Gate {
  boolean value;

  OutputGate() {
    super(1, "OUTPUT");
  }

  boolean _compute(boolean[] inputs) {
    this.value = inputs[0];
    return inputs[0];
  }

  void _show() {
    noStroke();
    fill(60);
    circle(this.x, this.y, 20);
    if (this.value)
      fill(52, 149, 235);
    else
      fill(0);
    circle(this.x, this.y, 15);
  }

  boolean mouseOver() {
    return (sqrt(pow(mouseX - this.x, 2) + pow(mouseY - this.y, 2)) < 10);
  }

  PVector inputPos(int _) {
    return new PVector(this.x, this.y);
  }

  // Should never be called because outputs don't have outputs
  PVector outputPos() {
    assert(true == false);
    return null;
  }
}

class AndGate extends Gate {
  AndGate() {
    super(2, "AND");
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] & inputs[1];
  }

  void _show() {
    noStroke();
    fill(30);
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, PIE);
    rect(this.x - 25, this.y - 20, 25, 40);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 20 && mouseY > this.y - 20 && mouseY < this.y + 20);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 15 : this.y + 15;
    return new PVector(this.x - 20, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 15, this.y);
  }
}

class NotGate extends Gate {
  NotGate() {
    super(1, "NOT");
  }

  boolean _compute(boolean[] inputs) {
    return !inputs[0];
  }

  void _show() {
    fill(30);
    triangle(this.x - 25, this.y - 15, this.x - 25, this.y + 15, this.x, this.y);
    circle(this.x + 5, this.y, 10);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 10 && mouseY > this.y - 15 && mouseY < this.y + 15);
  }

  PVector inputPos(int _) {
    return new PVector(this.x - 20, this.y);
  }

  PVector outputPos() {
    return new PVector(this.x + 5, this.y);
  }
}
