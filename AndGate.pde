class AndGate extends Gate {
  AndGate() {
    super(2);
  }

  AndGate(int x, int y) {
    super(2, x, y);
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] & inputs[1];
  }

  void show() {
    // Draw lines connecting inputs and outputs
    stroke(0);
    strokeWeight(3);
    line(this.inputPos(0).x, this.inputPos(0).y, this.x - 20, this.inputPos(0).y);
    line(this.inputPos(1).x, this.inputPos(1).y, this.x - 20, this.inputPos(1).y);
    line(this.x + 20, this.outputPos().y, this.outputPos().x, this.outputPos().y);

    // Draw main shape
    noFill();
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, OPEN);
    line(this.x - 20, this.y - 20, this.x - 20, this.y + 20);
    line(this.x - 20, this.y - 20, this.x, this.y - 20);
    line(this.x - 20, this.y + 20, this.x, this.y + 20);

    // Draw inputs and outputs
    stroke(0);
    fill(250);
    strokeWeight(1);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12);
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  PVector inputPos(int inputNum) {
    float y = inputNum == 0 ? this.y - 15 : this.y + 15;
    return new PVector(this.x - 40, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 35, this.y);
  }

  boolean pointTouching(float x, float y) {
    return (x > this.x - 20 && x < this.x + 20 && y > this.y - 20 && y < this.y + 20);
  }
}
