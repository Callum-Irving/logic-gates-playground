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
  void addConnection(String srcId, String destId, int inputNum) {
    this.gates.get(destId).setInput(inputNum, srcId);
    if (this.gates.containsKey(srcId))
      this.gates.get(srcId).addOutput(destId);
    else
      this.inputs.get(srcId).add(destId);
  }

  void compute(HashMap<String, Boolean> inputs) {
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
        // TODO: Somehow evaluate each connection and store in outputs

        current = queue.poll();
        if (this.gates.containsKey(current)) {
          for (String dest : this.gates.get(current).outputs) {
            println(current, "->", dest);
            queue.add(dest);
          }
        } else {
          for (String dest : this.inputs.get(current)) {
            println(current, "->", dest);
            int index = 0; // TODO: position of current in dest.outputs
            outputs.get(dest)[index] = inputs.get(current);
            queue.add(dest);
          }
        }
      }

      // Too many scopes
    }
  }
}
