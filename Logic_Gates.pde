/*
 * BUGS:
 *   - When something that connects to an output is disconnected, the output does not turn off
 *      - Not a big issue because it doesn't make sense to use disconnected outputs anyways
 *   - It is possible to drag gates off the screen and impossible to get them back on
 *   - When user adds multiple gates with the same name
 *
 * TODO:
 *   - [x] Add ability to create gates with keyboard
 *   - [x] Add more gates
 *   - [x] Delete gates with right click
 *   - [ ] Serialize and deserialize circuit
 *      - Use XML to store gates?
 *      - Could also use JSON
 *   - [ ] Zoom in and out
 *      - Requires some changes to coordinate system
 *   - [ ] Pick consistent design for gates (wire style preffered to fill)
 *   - [ ] Remove side effects from functions (mouseX and mouseY in drawing)
 *   - [ ] Ability to copy and paste groups of gates
 *      - Requires drag select
 *   - [ ] Comment code
 *   - [ ] Move overInput and overOutput to abstract class
 *      - For input in inputs: if distance(x, y, input) < 5 return i else return -1
 *
 * Refactor:
 *   - [ ] Move redraw out of UI
 *   - [ ] Avoid having to access circuit.gates directly from outside
 *   - [ ] Make sure API and UI interface are both good
 *   - [ ] Cleaner abstract gate class (maybe make an interface???)
 *   - [ ] Simplify all the mouseOverInput() stuff
 *   - [ ] Clean up addGate stuff in circuit
 *   - [ ] Move some of gate removing code to circuit class instead of UI
 *   - [ ] Use outputPos and inputPos in all show functions
 */

UiState ui;

void setup() {
  Circuit circ = new Circuit();

  // Create 4 bit adder
  circ.addInput("a1", 50, 100);
  circ.addInput("a2", 50, 130);
  circ.addInput("a3", 50, 160);
  circ.addInput("a4", 50, 190);

  circ.addInput("b1", 50, 400);
  circ.addInput("b2", 50, 430);
  circ.addInput("b3", 50, 460);
  circ.addInput("b4", 50, 490);

  circ.addOutput("s1", 1000, 200);
  circ.addOutput("s2", 1000, 230);
  circ.addOutput("s3", 1000, 260);
  circ.addOutput("s4", 1000, 290);
  circ.addOutput("s5", 1000, 320);

  // Half adder
  circ.addGate("h_and", new AndGate(200, 150));
  circ.addGate("h_xor", new XorGate(215, 100));
  circ.addConnection("a1", "h_and", 0);
  circ.addConnection("b1", "h_and", 1);
  circ.addConnection("a1", "h_xor", 0);
  circ.addConnection("b1", "h_xor", 1);
  circ.addConnection("h_xor", "s1", 0);

  // Full adder 1
  circ.addGate("f1_and1", new AndGate(300, 150));
  circ.addGate("f1_and2", new AndGate(400, 150));
  circ.addGate("f1_xor1", new XorGate(300, 200));
  circ.addGate("f1_xor2", new XorGate(400, 200));
  circ.addGate("f1_or", new OrGate(500, 200));
  circ.addConnection("h_and", "f1_xor2", 0);
  circ.addConnection("h_and", "f1_and2", 0);
  circ.addConnection("a2", "f1_xor1", 0);
  circ.addConnection("b2", "f1_xor1", 1);
  circ.addConnection("a2", "f1_and1", 0);
  circ.addConnection("b2", "f1_and1", 1);
  circ.addConnection("f1_and1", "f1_or", 0);
  circ.addConnection("f1_xor1", "f1_and2", 1);
  circ.addConnection("f1_xor1", "f1_xor2", 1);
  circ.addConnection("f1_and2", "f1_or", 1);
  circ.addConnection("f1_xor2", "s2", 0);

  // Full adder 2
  circ.addGate("f2_and1", new AndGate(400, 250));
  circ.addGate("f2_and2", new AndGate(500, 250));
  circ.addGate("f2_xor1", new XorGate(400, 300));
  circ.addGate("f2_xor2", new XorGate(500, 300));
  circ.addGate("f2_or", new OrGate(600, 300));
  circ.addConnection("f1_or", "f2_xor2", 0);
  circ.addConnection("f1_or", "f2_and2", 0);
  circ.addConnection("a3", "f2_xor1", 0);
  circ.addConnection("b3", "f2_xor1", 1);
  circ.addConnection("a3", "f2_and1", 0);
  circ.addConnection("b3", "f2_and1", 1);
  circ.addConnection("f2_and1", "f2_or", 0);
  circ.addConnection("f2_xor1", "f2_and2", 1);
  circ.addConnection("f2_xor1", "f2_xor2", 1);
  circ.addConnection("f2_and2", "f2_or", 1);
  circ.addConnection("f2_xor2", "s3", 0);

  // Full adder 3
  circ.addGate("f3_and1", new AndGate(500, 350));
  circ.addGate("f3_and2", new AndGate(600, 350));
  circ.addGate("f3_xor1", new XorGate(500, 400));
  circ.addGate("f3_xor2", new XorGate(600, 400));
  circ.addGate("f3_or", new OrGate(700, 400));
  circ.addConnection("f2_or", "f3_xor2", 0);
  circ.addConnection("f2_or", "f3_and2", 0);
  circ.addConnection("a4", "f3_xor1", 0);
  circ.addConnection("b4", "f3_xor1", 1);
  circ.addConnection("a4", "f3_and1", 0);
  circ.addConnection("b4", "f3_and1", 1);
  circ.addConnection("f3_and1", "f3_or", 0);
  circ.addConnection("f3_xor1", "f3_and2", 1);
  circ.addConnection("f3_xor1", "f3_xor2", 1);
  circ.addConnection("f3_and2", "f3_or", 1);
  circ.addConnection("f3_xor2", "s4", 0);

  circ.addConnection("f3_or", "s5", 0);

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
  if (mouseButton == LEFT) {
    ui.clicked();
  } else if (mouseButton == RIGHT) {
    ui.deleteGate();
  }
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
