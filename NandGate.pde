class NandGate extends Gate {
  NandGate() {
    super(2);
  }

  NandGate(int x, int y) {
    super(2, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return !(inputs[0] & inputs[1]);
  }

  void _show() {
    stroke(0);
    strokeWeight(3);
    noFill();

    // Draw main shape
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, OPEN);
    line(this.x - 20, this.y - 20, this.x - 20, this.y + 20);
    line(this.x - 20, this.y - 20, this.x, this.y - 20);
    line(this.x - 20, this.y + 20, this.x, this.y + 20);
    circle(this.x + 26, this.y, 12);
    
    // Draw lines connecting inputs and outputs
    line(this.inputPos(0).x, this.inputPos(0).y, this.x - 20, this.inputPos(0).y);
    line(this.inputPos(1).x, this.inputPos(1).y, this.x - 20, this.inputPos(1).y);
    line(this.x + 32, this.outputPos().y, this.outputPos().x, this.outputPos().y);
  }

  boolean pointTouching(float x, float y) {
    return (x > this.x - 20 && x < this.x + 20 && y > this.y - 20 && y < this.y + 20);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 15 : this.y + 15;
    return new PVector(this.x - 40, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 45, this.y);
  }
}
