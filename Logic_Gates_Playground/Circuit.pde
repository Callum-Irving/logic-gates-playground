import java.util.LinkedList;
import java.util.HashSet;
import java.util.Map;

class Circuit {
  // We can't just use gates.size() because if we create 3 gates then remove the second,
  // we will end up overwriting the third gate every time we create a new one.
  int gateCount = 0;

  HashMap<String, Gate> gates;

  Circuit() {
    this.gates = new HashMap<String, Gate>();
  }

  void addGate(String id, Gate g) {
    // Prevents adding two gates with the same name
    if (this.gates.containsKey(id)) {
      println("Could not add gate '" + id + "' because a gate with this name already exists");
      return;
    }
    this.gateCount++;
    this.gates.put(id, g);
  }

  void addGate(Gate g) {
    String id = "gate" + this.gateCount;
    this.addGate(id, g);
  }

  // TODO: Prevent cycle in this function
  void addConnection(String srcId, String destId, int destIndex) {
    Gate src = this.gates.get(srcId);
    src.addConnection(srcId, destId, this.gates.get(destId), destIndex);
  }

  void removeGate(String id) {
    // Remove all incoming connections
    for (Gate input : this.gates.get(id).inputs) {
      if (input == null) continue;
      int i = 0;
      while (i < input.connections.size()) {
        // Remove connection if the destination is the gate we are removing
        // We needs to use .equals() instead of == because we are checking referenced objects (strings)
        if (input.connections.get(i).destId.equals(id))
          input.connections.remove(i);
        else
          i++;
      }
    }

    this.gates.remove(id);
    this.compute();
  }

  void compute() {
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
