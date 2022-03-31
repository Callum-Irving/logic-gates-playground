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

class InputGate extends Gate {
  InputGate() {
    super(0);
  }

  void setVal(boolean val) {
    this.output = val;
  }

  boolean _compute(boolean[] inputs) {
    return this.output;
  }

  void show() {
    stroke(60);
    strokeWeight(2.5);
    if (this.output)
      fill(235, 235, 52);
    else
      fill(0);
    square(this.x - 7.5, this.y - 7.5, 15);

    fill(250);
    stroke(0);
    strokeWeight(1);
    circle(this.x + 7.5, this.y, 10);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 10 && mouseX < this.x + 10 && mouseY > this.y - 10 && mouseY < this.y + 10);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX - this.x - 7.5, 2) + pow(mouseY - this.y, 2)) < 10);
  }

  int mouseOverInput() {
    return -1;
  }

  // Inputs don't take inputs so this should never be called
  PVector inputPos(int _) {
    assert(true == false);
    return null;
  }

  PVector outputPos() {
    return new PVector(this.x + 7.5, this.y);
  }
}

class OutputGate extends Gate {
  OutputGate() {
    super(1);
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0];
  }

  void show() {
    noStroke();
    fill(60);
    circle(this.x, this.y, 20);
    if (this.output)
      fill(52, 149, 235);
    else
      fill(0);
    circle(this.x, this.y, 15);
  }

  boolean mouseOver() {
    return (sqrt(pow(mouseX - this.x, 2) + pow(mouseY - this.y, 2)) < 10);
  }

  boolean mouseOverOutput() {
    return false;
  }

  int mouseOverInput() {
    if (sqrt(pow(mouseX - this.x, 2) + pow(mouseY - this.y, 2)) < 10)
      return 0;
    else
      return -1;
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
    super(2);
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] & inputs[1];
  }

  void show() {
    noStroke();
    fill(30);
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, PIE);
    rect(this.x - 25, this.y - 20, 25, 40);

    // Draw inputs and outputs
    fill(250);
    strokeWeight(1);
    stroke(0);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12);
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 20 && mouseY > this.y - 20 && mouseY < this.y + 20);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX - this.x - 15, 2) + pow(mouseY - this.y, 2)) < 6);
  }

  int mouseOverInput() {
    if (sqrt(pow(mouseX - this.inputPos(0).x, 2) + pow(mouseY - this.inputPos(0).y, 2)) < 6) {
      return 0;
    } else if (sqrt(pow(mouseX - this.inputPos(1).x, 2) + pow(mouseY - this.inputPos(1).y, 2)) < 6) {
      return 1;
    } else {
      return -1;
    }
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
    super(1);
  }

  boolean _compute(boolean[] inputs) {
    return !inputs[0];
  }

  void show() {
    fill(30);
    triangle(this.x - 25, this.y - 15, this.x - 25, this.y + 15, this.x, this.y);
    stroke(0);
    strokeWeight(1);
    fill(250);
    circle(this.x - 25, this.y, 10);
    circle(this.x + 5, this.y, 10);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 10 && mouseY > this.y - 15 && mouseY < this.y + 15);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX - this.x - 5, 2) + pow(mouseY - this.y, 2)) < 5);
  }

  int mouseOverInput() {
    if (sqrt(pow(mouseX - this.x + 25, 2) + pow(mouseY - this.y, 2)) < 5)
      return 0;
    else
      return -1;
  }

  PVector inputPos(int _) {
    return new PVector(this.x - 25, this.y);
  }

  PVector outputPos() {
    return new PVector(this.x + 5, this.y);
  }
}
