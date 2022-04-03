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
    // Draw main shape
    noFill();
    stroke(0);
    strokeWeight(3);
    triangle(this.x - 25, this.y - 15, this.x - 25, this.y + 15, this.x, this.y);
    circle(this.x + 7, this.y, 12);
    
    // Draw lines connecting input and output
    line(this.inputPos(0).x, this.inputPos(0).y, this.x - 25, this.y);
    line(this.outputPos().x, this.outputPos().y, this.x + 13, this.y);
    
    // Draw inputs and outputs
    strokeWeight(1);
    fill(250);
    circle(this.inputPos(0).x, this.inputPos(0).y, 12) ;
    circle(this.outputPos().x, this.outputPos().y, 12);
  }

  PVector inputPos(int _index) {
    return new PVector(this.x - 40, this.y);
  }

  PVector outputPos() {
    return new PVector(this.x + 25, this.y);
  }

  boolean pointTouching(float x, float y) {
    return (x > this.x - 25 && x < this.x + 10 && y > this.y - 15 && y < this.y + 15);
  }
}
