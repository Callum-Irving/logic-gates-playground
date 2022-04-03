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

  void addGate(String id, Gate g) {
    // Prevents add two gates with the same name
    if (this.gates.containsKey(id)) {
      println("Could not add gate '" + id + "' because a gate with this name already exists");
      return;
    }
    this.gates.put(id, g);
  }

  void addGate(Gate g) {
    String id = "gate" + str(this.gates.size());
    this.gates.put(id, g);
  }

  // TODO: Prevent cycle in this function
  void addConnection(String srcId, String destId, int destIndex) {
    Gate src = this.gates.get(srcId);
    src.addConnection(srcId, destId, this.gates.get(destId), destIndex);
  }

  void compute() {
    // Get subset of gates that are InputGates

    HashMap<String, boolean[]> outputs = new HashMap<String, boolean[]>();

    for (String id : this.gates.keySet()) {
      outputs.put(id, new boolean[this.gates.get(id).numInputs]);
    }

    LinkedList<Connection> queue = new LinkedList<Connection>();

    for (Gate input : this.gates.values()) {
      if (!(input instanceof InputGate)) continue;
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
