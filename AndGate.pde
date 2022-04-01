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
    noStroke();
    fill(30);
    arc(this.x, this.y, 40, 40, -HALF_PI, HALF_PI, PIE);
    rect(this.x - 25, this.y - 20, 25, 40);

    // Draw inputs and outputs
    fill(250);
    strokeWeight(1);
    stroke(0);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12);
    circle(this.inputPos(1).x, this.inputPos(1).y, 12);
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 20 && mouseY > this.y - 20 && mouseY < this.y + 20);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX - this.x - 15, 2) + pow(mouseY - this.y, 2)) < 6);
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
    return new PVector(this.x - 20, y);
  }

  PVector outputPos() {
    return new PVector(this.x + 15, this.y);
  }
}
