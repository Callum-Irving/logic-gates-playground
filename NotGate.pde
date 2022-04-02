class NotGate extends Gate {
  NotGate() {
    super(1);
  }

  NotGate(int x, int y) {
    super(1, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return !inputs[0];
  }

  void show() {
    fill(30);
    noStroke();
    triangle(this.x - 25, this.y - 15, this.x - 25, this.y + 15, this.x, this.y);
    stroke(0);
    strokeWeight(1);
    fill(250);
    circle(this.x - 25, this.y, 10);
    circle(this.x + 5, this.y, 10);
  }

  PVector inputPos(int _index) {
    return new PVector(this.x - 25, this.y);
  }

  PVector outputPos() {
    return new PVector(this.x + 5, this.y);
  }

  boolean pointTouching(int x, int y) {
    return (x > this.x - 25 && x < this.x + 10 && y > this.y - 15 && y < this.y + 15);
  }

  int overInput(int x, int y) {
    if (distance(x, y, this.inputPos(0).x, this.inputPos(0).y) < 5)
      return 0;
    else
      return -1;
  }

  boolean overOutput(int x, int y) {
    return (distance(x, y, this.outputPos().x, this.outputPos().y) < 5);
  }
}
