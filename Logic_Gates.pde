UiState ui;
Circuit circ;
Gate selected = null;

void setup() {
  circ = new Circuit();

  circ.addInput("input0", new InputGate());
  circ.addInput("input1", new InputGate());
  circ.addInput("input2", new InputGate());
  circ.addGate("and0", new AndGate());
  circ.addGate("and1", new AndGate());
  circ.addGate("not0", new NotGate());
  circ.addOutput("output0", new OutputGate());
  circ.addOutput("output1", new OutputGate());

  circ.addConnection("input0", "and0", 0);
  circ.addConnection("input1", "and0", 1);
  circ.addConnection("input2", "and1", 1);
  circ.addConnection("and0", "and1", 0);
  circ.addConnection("and1", "not0", 0);
  circ.addConnection("and1", "output0", 0);
  //circ.addConnection("not0", "output1", 0);

  ui = new UiState(circ);

  //boolean[] inputs = {true, true, true};

  //println("IN    | OUT");
  //println("-----------");
  //for (int i = 0; i < 8; i++) {
  //  inputs[0] = boolean(i & 1);
  //  inputs[1] = boolean(i & 2);
  //  inputs[2] = boolean(i & 4);

  //  circ.setInputs(inputs);
  //  circ.compute();

  //  print(int(inputs[0]), int(inputs[1]), int(inputs[2]), "| ");
  //  println(int(circ.outputs.get("output0").output), int(circ.outputs.get("output1").output));
  //}

  size(1280, 720);
  textSize(72);
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
