/*
 * Logic Gates Playground
 *
 * Author: Callum Irving
 * Date: April 4th, 2022
 *
 * DESCRIPTION:
 *   This is a program for messing around with logic gates. You can create logic
 *   gates and connections between them to see what happens. It also has the
 *   ability to save and load circuits using JSON.
 *
 * CONTROLS:
 *   Left click and drag - move gate
 *   Middle click and drag - pan
 *   Scroll wheel - zoom in and out
 *   Left click - toggle input
 *   Right click - delete gate
 *   'l' - load saved circuit
 *   's' - save current circuit
 *
 *   Gate creation:
 *     '1' - create input gate
 *     '2' - create output gate
 *     'a' - create AND gate
 *     'A' - create NAND gate
 *     'o' - create OR gate
 *     'O' - create NOR gate
 *     'x' - create XOR gate
 *     'X' - create XNOR gate
 *     'n' - create NOT gate
 */

UiState ui;

void setup() {
  Circuit circ = new Circuit();

  // Create 4 bit adder
  circ.addGate("a1", new InputGate(50, 100));
  circ.addGate("a2", new InputGate(50, 130));
  circ.addGate("a3", new InputGate(50, 160));
  circ.addGate("a4", new InputGate(50, 190));

  circ.addGate("b1", new InputGate(50, 400));
  circ.addGate("b2", new InputGate(50, 430));
  circ.addGate("b3", new InputGate(50, 460));
  circ.addGate("b4", new InputGate(50, 490));

  circ.addGate("s1", new OutputGate(1000, 200));
  circ.addGate("s2", new OutputGate(1000, 230));
  circ.addGate("s3", new OutputGate(1000, 260));
  circ.addGate("s4", new OutputGate(1000, 290));
  circ.addGate("s5", new OutputGate(1000, 320));

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

  //ui = new UiState(circ);
  ui = new UiState(new Circuit());

  size(1280, 720);
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

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  ui.zoom(e);
}

void keyPressed() {
  ui.keyDown();
}
