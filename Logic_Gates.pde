UiState ui;
Circuit circ;
Gate selected = null;

void setup() {
  circ = new Circuit();

  circ.addInput("input0");
  circ.addInput("input1");
  circ.addInput("input2");
  circ.addGate("and0", new AndGate());
  circ.addGate("and1", new AndGate());
  circ.addGate("not0", new NotGate());
  circ.addOutput("output0");
  circ.addOutput("output1");

  circ.addConnection("input0", "and0", 0);
  circ.addConnection("input1", "and0", 1);
  circ.addConnection("input2", "and1", 1);
  circ.addConnection("and0", "and1", 0);
  circ.addConnection("and1", "not0", 0);
  circ.addConnection("and1", "output0", 0);
  circ.addConnection("not0", "output1", 0);

  ui = new UiState(circ);

  size(1280, 720);
  noLoop();
  redraw();
}

void draw() {
  background(230);

  ui.show();
}

void mouseClicked() {
  ui.toggleInput();
}

void mousePressed() {
  ui.select();
}

void mouseReleased() {
  ui.deselect();
}

void mouseDragged() {
  ui.dragged();
}
