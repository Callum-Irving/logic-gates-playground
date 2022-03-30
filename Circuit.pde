import java.util.HashSet;
import java.util.LinkedList;

class Circuit {
  HashMap<String, Gate> gates;
  // TODO: Something about inputs

  // Input names
  // These are their own thing so that we can loop through them
  // They also are not gates
  HashMap<String, ArrayList<String>> inputs;

  Circuit() {
    this.gates = new HashMap<String, Gate>();
    this.inputs = new HashMap<String, ArrayList<String>>();
  }

  void addInput(String id) {
    this.inputs.put(id, new ArrayList<String>());
  }

  void addGate(String id, Gate g) {
    this.gates.put(id, g);
  }

  // TODO: Prevent cycles
  void addConnection(String srcId, String destId) {
    int i = 0;
    Gate dest = this.gates.get(destId);
    while (dest.inputs[i] != null) {
      i++;
      if (i == dest.numInputs) return;
    }
    dest.inputs[i] = srcId;
    Gate src = this.gates.get(srcId);
    if (src == null) {
      this.inputs.get(srcId).add(destId);
    } else {
      src.outputs.add(destId);
    }
  }

  void compute() {
    HashMap<String, boolean[]> outputs = new HashMap<String, boolean[]>();

    // Copy all keys from this.gates and set sizes for arrays
    // The size of each boolean[] should be the length of that gate's inputs
    for (String id : this.gates.keySet()) {
      outputs.put(id, new boolean[this.gates.get(id).numInputs]);
    }

    String current;

    // Then bfs from each input I guess
    for (String input : this.inputs.keySet()) {
      LinkedList<String> queue = new LinkedList<String>();
      queue.add(input);
      while (queue.size() != 0) {
        current = queue.poll();
        if (this.gates.containsKey(current)) {
          for (String dest : this.gates.get(current).outputs) {
            println(current, "->", dest);
            queue.add(dest);
          }
        } else {
          for (String dest : this.inputs.get(current)) {
            println(current, "->", dest);
            queue.add(dest);
          }
        }
      }

      // Too many scopes
    }
  }
}
