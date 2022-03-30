void setup() {
  exit();

  Circuit c = new Circuit();
  c.addGate("and1", new AND());
  c.addInput("input1");
  c.addConnection("input1", "and1", 0);
  c.addGate("and2", new AND());
  c.addConnection("input1", "and2", 1);
  c.addConnection("and1", "and2", 0);
  c.addConnection("input1", "and1", 1);
  c.compute();
}

void draw() {
}
