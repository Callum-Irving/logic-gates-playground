import java.util.HashMap;

// Need some sort of graph representation for a circuit made of logic gates
// Make sure loops are not allowed

class Circuit {
  HashMap<String, BaseGate> gates;
  HashMap<String, ArrayList<String>> connections;

  // Returns true if successfull
  boolean addGate(String name, BaseGate gate) {
    if (this.gates.get(name) == null) return false;
    this.gates.put(name, gate);
    return true;
  }

  // Remove gate and all its connections
  void removeGate(String name) {
    this.gates.remove(name);
    this.connections.remove(name);
    // TODO: Remove all connections where the dest is name
    // Iterate through this.connections
  }

  boolean addConnection(String src, String dest) {
    ArrayList<String> cons = this.connections.get(src);
    if (cons == null) return false;
    cons.add(dest);
    return true;
  }
}
