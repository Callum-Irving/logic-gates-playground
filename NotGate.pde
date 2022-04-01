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

  boolean mouseOver() {
    return (mouseX > this.x - 25 && mouseX < this.x + 10 && mouseY > this.y - 15 && mouseY < this.y + 15);
  }

  boolean mouseOverOutput() {
    return (sqrt(pow(mouseX - this.x - 5, 2) + pow(mouseY - this.y, 2)) < 5);
  }

  int mouseOverInput() {
    if (sqrt(pow(mouseX - this.x + 25, 2) + pow(mouseY - this.y, 2)) < 5)
      return 0;
    else
      return -1;
  }

  PVector inputPos(int _index) {
    return new PVector(this.x - 25, this.y);
  }

  PVector outputPos() {
    return new PVector(this.x + 5, this.y);
  }
}
