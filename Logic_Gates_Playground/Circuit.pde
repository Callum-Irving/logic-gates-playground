import java.util.LinkedList;
import java.util.HashSet;
import java.util.Map;

class Circuit {
  // We can't just use gates.size() because if we remove a gate that isn't the
  // last, we will overwrite it every time we create a new gate.
  int gateCount = 0;

  // Maps gate IDs to gate objects.
  HashMap<String, Gate> gates;

  Circuit() {
    this.gates = new HashMap<String, Gate>();
  }

  // Propagates the inputs throughout the circuit, calling the compute() method
  // of each connected gate. This method works by doing a breadth-first search
  // from each input gate. It stores the outputs of all the gates in an
  // intermediary HashMap.
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

  // Add a new gate with a custom ID. Makes sure that you don't add a duplicate
  // gate ID.
  void addGate(String id, Gate g) {
    // Prevents adding two gates with the same name.
    if (this.gates.containsKey(id)) {
      println("Could not add gate '" + id + "' because a gate with this name already exists");
      return;
    }
    this.gateCount++;
    this.gates.put(id, g);
  }

  // Adds a new gate with an ID based on the number of gates.
  void addGate(Gate g) {
    String id = "gate" + this.gateCount;
    this.addGate(id, g);
  }

  // Add a connection from one gate to another. This method also check that
  // there isn't a cycle which would lead to the compute method never ending.
  void addConnection(String srcId, String destId, int destIndex) {
    Gate src = this.gates.get(srcId);

    // Check all connections from dest. If we hit src, there was a cycle.
    LinkedList<Connection> queue = new LinkedList<Connection>();
    for (Connection c : this.gates.get(destId).connections) {
      queue.add(c);
    }

    while (queue.size() != 0) {
      Connection c = queue.poll();
      if (c.destId.equals(srcId)) {
        println("ERROR: Connection from '" + srcId + "' to '" + destId + "' causes a cycle");
        return;
      }
      for (Connection d : c.dest.connections) {
        queue.add(d);
      }
    }

    src.addConnection(srcId, destId, this.gates.get(destId), destIndex);
  }

  // Removes a gate as well as all its incoming and outgoing connections.
  void removeGate(String id) {
    // Remove all incoming connections.
    for (Gate input : this.gates.get(id).inputs) {
      if (input == null) continue;
      int i = 0;
      while (i < input.connections.size()) {
        // Remove connection if the destination is the gate we are removing We
        // need to use .equals() instead of == because we are checking
        // strings which are referenced objects.
        if (input.connections.get(i).destId.equals(id))
          input.connections.remove(i);
        else
          i++;
      }
    }

    this.gates.remove(id);
    this.compute();
  }
}
