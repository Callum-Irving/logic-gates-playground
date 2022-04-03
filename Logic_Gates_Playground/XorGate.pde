class XorGate extends Gate {
  XorGate() {
    super(2);
  }

  XorGate(int x, int y) {
    super(2, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] ^ inputs[1];
  }

  void _show() {
    stroke(0);
    strokeWeight(3);
    noFill();

    // Main shape
    curve(this.x - 65, this.y - 40, this.x - 35, this.y - 20, this.x - 35, this.y + 20, this.x - 65, this.y + 40);
    curve(this.x - 55, this.y - 40, this.x - 25, this.y - 20, this.x - 25, this.y + 20, this.x - 55, this.y + 40);
    curve(this.x - 55, this.y - 20, this.x - 25, this.y - 20, this.x + 15, this.y, this.x + 35, this.y + 40);
    curve(this.x - 55, this.y + 20, this.x - 25, this.y + 20, this.x + 15, this.y, this.x + 35, this.y - 40);

    // Lines connecting inputs and outputs
    line(this.x - 55, this.y - 10, this.x - 22, this.y - 10);
    line(this.x - 55, this.y + 10, this.x - 22, this.y + 10);
    line(this.x + 15, this.y, this.x + 30, this.y);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 10 : this.y + 10;
    return new PVector(this.x - 55, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 30, this.y);
  }


  boolean pointTouching(float x, float y) {
    return (x > this.x - 25 && x < this.x + 20 && y > this.y - 20 && y < this.y + 20);
  }
}
