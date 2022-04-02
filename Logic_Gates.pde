/*
 * TODO:
 *   - [x] Add ability to create gates with keyboard
 *   - [ ] Add more gates
 *      - Still need NAND, NOR, and XNOR
 *   - [ ] Delete gates with right click
 *   - [ ] Serialize and deserialize circuit
 *      - Use XML to store gates?
 *      - Could also use JSON
 *   - [ ] Zoom in and out
 *      - Requires some changes to coordinate system
 *   - [ ] Pick consistent design for gates (wire style preffered to fill)
 *   - [ ] Remove side effects from functions (mouseX and mouseY in drawing)
 *   - [ ] Ability to copy and paste groups of gates
 *      - Requires drag select
 *
 * Refactor:
 *   - [ ] Move redraw out of UI
 *   - [ ] Avoid having to access circuit.gates directly from outside
 *   - [ ] Make sure API and UI interface are both good
 *   - [ ] Cleaner abstract gate class (maybe make an interface???)
 *   - [ ] Simplify all the mouseOverInput() stuff
 */

UiState ui;

void setup() {
  Circuit circ = new Circuit();

  //circ.addInput("input0");
  //circ.addInput("input1");
  //circ.addInput("input2");
  //circ.addGate("and0", new AndGate());
  //circ.addGate("and1", new AndGate());
  //circ.addGate("not0", new NotGate());
  //circ.addOutput("output0");
  //circ.addOutput("output1");

  //circ.addConnection("input0", "and0", 0);
  //circ.addConnection("input1", "and0", 1);
  //circ.addConnection("input2", "and1", 1);
  //circ.addConnection("and0", "and1", 0);
  //circ.addConnection("and1", "not0", 0);
  //circ.addConnection("and1", "output0", 0);
  //circ.addConnection("not0", "output1", 0);

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
  ui.clicked();
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

void keyPressed() {
  ui.createGate(key);
}
