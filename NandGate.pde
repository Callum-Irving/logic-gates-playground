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

  void show() {
    // Draw lines connecting inputs and outputs
    stroke(0);
    strokeWeight(3);
    line(this.inputPos(0).x, this.inputPos(0).y, this.x - 20, this.inputPos(0).y);
    line(this.inputPos(1).x, this.inputPos(1).y, this.x - 20, this.inputPos(1).y);
    line(this.x, this.outputPos().y, this.outputPos().x, this.outputPos().y);

    // Draw main shape
    noStroke();
    fill(30);
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, PIE);
    rect(this.x - 20, this.y - 20, 20, 40);
    circle(this.x + 26, this.y, 14);

    // Draw inputs and outputs
    stroke(0);
    fill(250);
    strokeWeight(1);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12);
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 20 && mouseX < this.x + 20 && mouseY > this.y - 20 && mouseY < this.y + 20);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX -this.outputPos().x, 2) + pow(mouseY - this.outputPos().y, 2)) < 6);
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
    return new PVector(this.x - 40, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 45, this.y);
  }
}