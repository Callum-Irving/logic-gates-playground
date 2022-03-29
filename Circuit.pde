import java.util.HashMap;
import java.util.LinkedList;

// Need some sort of graph representation for a circuit made of logic gates
// Make sure loops are not allowed

class Circuit {
  // TODO: Implement serialize interface for basegate then remove gates
  HashMap<String, BaseGate> gates;
  HashMap<String, ArrayList<String>> connections;
  int numVerts = 0;
  int numInputs = 0;

  Circuit() {
    // TODO
  }

  // TODO
  void addInput(String name) {
  }

  // Returns true if successfull
  boolean addGate(String name, BaseGate gate) {
    if (this.gates.get(name) == null) return false;
    this.gates.put(name, gate);
    this.numVerts++;
    return true;
  }

  // Remove gate and all its connections
  void removeGate(String name) {
    this.gates.remove(name);
    this.connections.remove(name);
    this.numVerts--;
    // TODO: Remove all connections where the dest is name
    // Iterate through this.connections
  }

  boolean addConnection(String src, String dest) {
    ArrayList<String> cons = this.connections.get(src);
    if (cons == null) return false;
    cons.add(dest);
    return true;
  }

  void compute(boolean[] inputs) {
    if (inputs.length != this.numInputs) return;
    // TODO
  }

  void bfs(String src) {
    // visited array/hashmap
    LinkedList<String> queue = new LinkedList<String>();
  }
}
