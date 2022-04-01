class InputGate extends Gate {
  InputGate() {
    super(0);
  }

  InputGate(int x, int y) {
    super(0, x, y);
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
    return (sqrt(pow(mouseX - this.x - 7.5, 2) + pow(mouseY - this.y, 2)) < 5);
  }

  int mouseOverInput() {
    return -1;
  }

  // Inputs don't take inputs so this should never be called
  PVector inputPos(int _index) {
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

  OutputGate(int x, int y) {
    super(1, x, y);
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

  PVector inputPos(int _index) {
    return new PVector(this.x, this.y);
  }

  // Should never be called because outputs don't have outputs
  PVector outputPos() {
    assert(true == false);
    return null;
  }
}
