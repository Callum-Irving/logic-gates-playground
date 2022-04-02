class OrGate extends Gate {
  OrGate() {
    super(2);
  }

  OrGate(int x, int y) {
    super(2, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] | inputs[1];
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(3);

    curve(this.x - 55, this.y - 40, this.x - 25, this.y - 20, this.x - 25, this.y + 20, this.x - 55, this.y + 40);
    curve(this.x - 55, this.y - 20, this.x - 25, this.y - 20, this.x + 15, this.y, this.x + 35, this.y + 40);
    curve(this.x - 55, this.y + 20, this.x - 25, this.y + 20, this.x + 15, this.y, this.x + 35, this.y - 40);
    line(this.x - 45, this.y - 10, this.x - 22, this.y - 10);
    line(this.x - 45, this.y + 10, this.x - 22, this.y + 10);
    line(this.x + 15, this.y, this.x + 30, this.y);

    fill(250);
    strokeWeight(1);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12) ;
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 10 : this.y + 10;
    return new PVector(this.x - 45, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 30, this.y);
  }

  boolean pointTouching(int x, int y) {
    return (x > this.x - 25 && x < this.x + 20 && y > this.y - 20 && y < this.y + 20);
  }

  int overInput(int x, int y) {
    if (distance(x, y, this.inputPos(0).x, this.inputPos(0).y) < 6)
      return 0;
    else if (distance(x, y, this.inputPos(1).x, this.inputPos(1).y) < 6)
      return 1;
    else
      return -1;
  }

  boolean overOutput(int x, int y) {
    return (distance(x, y, this.outputPos().x, this.outputPos().y) < 5);
  }
}
