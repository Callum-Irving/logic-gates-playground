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

  void _show() {
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
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  // Should never be called
  PVector inputPos(int _inputNum) {
    assert(true == false);
    return null;
  }

  PVector outputPos() {
    return new PVector(this.x + 7.5, this.y);
  }

  boolean pointTouching(float x, float y) {
    return (x > this.x  -10 && x < this.x + 10 && y > this.y - 10 && y < this.y + 10);
  }

  // An input gate doesn't take inputs so this is always -1
  @Override int overInput(float _x, float _y) {
    return -1;
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

  @Override void show() {
    this._show();
  }

  void _show() {
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

  boolean pointTouching(float x, float y) {
    return (distance(this.x, this.y, x, y) < 10);
  }

  @Override int overInput(float x, float y) {
    if (this.pointTouching(x, y))
      return 0;
    else
      return -1;
  }

  // Output gate doesn't have outputs
  @Override boolean overOutput(float x, float y) {
    return false;
  }
}
