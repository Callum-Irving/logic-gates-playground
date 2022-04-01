import java.util.LinkedList;
import java.util.HashSet;

class Circuit {
  HashMap<String, Gate> gates;
  ArrayList<InputGate> inputs;
  HashMap<String, OutputGate> outputs;

  Circuit() {
    this.gates = new HashMap<String, Gate>();
    this.inputs = new ArrayList<InputGate>();
    this.outputs = new HashMap<String, OutputGate>();
  }

  // TODO: create new InputGate in this function
  void addInput(String id) {
    InputGate g = new InputGate();
    this.inputs.add(g);
    this.addGate(id, g);
  }

  void addInput() {
    String id = "input" + str(this.inputs.size());
    InputGate g = new InputGate();
    this.inputs.add(g);
    this.addGate(id, g);
  }

  void addOutput(String id) {
    OutputGate g = new OutputGate();
    this.outputs.put(id, g);
    this.addGate(id, g);
  }

  void addOutput() {
    String id = "output" + str(this.outputs.size());
    OutputGate g = new OutputGate();
    this.outputs.put(id, g);
    this.addGate(id, g);
  }

  void addGate(String id, Gate g) {
    this.gates.put(id, g);
  }

  void addGate(Gate g) {
    String id = "gate" + str(this.gates.size());
    this.gates.put(id, g);
  }

  void addConnection(String srcId, String destId, int destIndex) {
    Gate src = this.gates.get(srcId);
    src.addConnection(srcId, destId, this.gates.get(destId), destIndex);
  }

  void setInputs(boolean[] inputs) {
    for (int i = 0; i < this.inputs.size(); i++) {
      this.inputs.get(i).setVal(inputs[i]);
    }
  }

  // Assumes that setInputs() has been called right before
  void compute() {
    HashMap<String, boolean[]> outputs = new HashMap<String, boolean[]>();

    for (String id : this.gates.keySet()) {
      outputs.put(id, new boolean[this.gates.get(id).numInputs]);
    }

    LinkedList<Connection> queue = new LinkedList<Connection>();

    for (InputGate input : this.inputs) {
      for (Connection c : input.connections) {
        queue.add(c);
      }
    }

    while (queue.size() != 0) {
      Connection c = queue.poll();
      boolean val = c.src.compute(outputs.get(c.srcId));
      outputs.get(c.destId)[c.destIndex] = val;

      // If it's an output, evaluate it
      if (this.outputs.containsKey(c.destId)) {
        c.dest.compute(outputs.get(c.destId));
      }

      for (Connection d : c.dest.connections) {
        queue.add(d);
      }
    }
  }
}
