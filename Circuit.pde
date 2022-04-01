import java.util.LinkedList;
import java.util.HashSet;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;

class Circuit {
  HashMap<String, Gate> gates;

  Circuit() {
    this.gates = new HashMap<String, Gate>();
  }

  void addInput(String id) {
    InputGate g = new InputGate();
    this.addGate(id, g);
  }

  void addInput() {
    String id = "gate" + str(this.gates.size());
    InputGate g = new InputGate(mouseX, mouseY);
    this.addGate(id, g);
  }

  void addOutput(String id) {
    OutputGate g = new OutputGate();
    this.addGate(id, g);
  }

  void addOutput() {
    String id = "gate" + str(this.gates.size());
    OutputGate g = new OutputGate(mouseX, mouseY);
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

  void compute() {
    // Processing autoformat breaks this code :(
    List<Gate> inputList = this.gates.entrySet().stream()
      .filter(x -> x.getValue() instanceof InputGate)
      .map(Map.Entry::getValue)
      .collect(Collectors.toList());


    HashMap<String, boolean[]> outputs = new HashMap<String, boolean[]>();

    for (String id : this.gates.keySet()) {
      outputs.put(id, new boolean[this.gates.get(id).numInputs]);
    }

    LinkedList<Connection> queue = new LinkedList<Connection>();

    for (Gate input : inputList) {
      for (Connection c : input.connections) {
        queue.add(c);
      }
    }

    while (queue.size() != 0) {
      Connection c = queue.poll();
      boolean val = c.src.compute(outputs.get(c.srcId));
      outputs.get(c.destId)[c.destIndex] = val;

      // If it's an output, evaluate it
      if (this.gates.get(c.destId) instanceof OutputGate) {
        c.dest.compute(outputs.get(c.destId));
      }

      for (Connection d : c.dest.connections) {
        queue.add(d);
      }
    }
  }
}
