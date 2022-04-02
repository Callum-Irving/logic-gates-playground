class XnorGate extends Gate {
  XnorGate() {
    super(2);
  }

  XnorGate(int x, int y) {
    super(2, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return !(inputs[0] ^ inputs[1]);
  }

  void show() {
    stroke(0);
    strokeWeight(3);
    noFill();

    curve(this.x - 65, this.y - 40, this.x - 35, this.y - 20, this.x - 35, this.y + 20, this.x - 65, this.y + 40);
    curve(this.x - 55, this.y - 40, this.x - 25, this.y - 20, this.x - 25, this.y + 20, this.x - 55, this.y + 40);
    curve(this.x - 55, this.y - 20, this.x - 25, this.y - 20, this.x + 15, this.y, this.x + 35, this.y + 40);
    curve(this.x - 55, this.y + 20, this.x - 25, this.y + 20, this.x + 15, this.y, this.x + 35, this.y - 40);
    line(this.x - 55, this.y - 10, this.x - 22, this.y - 10);
    line(this.x - 55, this.y + 10, this.x - 22, this.y + 10);
    line(this.x + 25, this.y, this.outputPos().x, this.outputPos().y);
    circle(this.x + 20, this.y, 10);

    fill(250);
    strokeWeight(1);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12) ;
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 10 : this.y + 10;
    return new PVector(this.x - 55, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 40, this.y);
  }

  boolean pointTouching(float x, float y) {
    return (x > this.x - 25 && x < this.x + 20 && y > this.y - 20 && y < this.y + 20);
  }
}
