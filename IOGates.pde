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

  // Should never be called
  PVector inputPos(int _inputNum) {
    assert(true == false);
    return null;
  }

  PVector outputPos() {
    return new PVector(this.x + 7.5, this.y);
  }

  boolean pointTouching(int x, int y) {
    return (x > this.x  -10 && x < this.x + 10 && y > this.y - 10 && y < this.y + 10);
  }

  // An input gate doesn't take inputs so this is always -1
  int overInput(int _x, int _y) {
    return -1;
  }

  boolean overOutput(int x, int y) {
    return (distance(this.outputPos().x, this.outputPos().y, x, y) < 5);
  }

  @Override void clicked() {
    this.output = !this.output;
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

  PVector inputPos(int _index) {
    return new PVector(this.x, this.y);
  }

  // Should never be called because outputs don't have outputs
  PVector outputPos() {
    assert(true == false);
    return null;
  }

  boolean pointTouching(int x, int y) {
    return (distance(this.x, this.y, x, y) < 10);
  }

  int overInput(int x, int y) {
    if (this.pointTouching(x, y))
      return 0;
    else
      return -1;
  }

  // Output gate doesn't have outputs
  boolean overOutput(int x, int y) {
    return false;
  }
}
