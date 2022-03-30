// TODO: Sort out access modifiers

abstract class Gate {
  int x, y; // For displaying on screen
  String[] inputs;
  ArrayList<String> outputs;

  int numInputs;
  abstract boolean _compute(boolean[] inputs);

  boolean compute(boolean[] inputs) {
    assert(inputs.length == this.numInputs);
    return this._compute(inputs);
  }

  // TODO
  void addOutput(String destId) {
    this.outputs.add(destId);
  }

  void setInput(int i, String srcId) {
    this.inputs[i] = srcId;
  }

  Gate(int n) {
    this.numInputs = n;
    this.inputs = new String[n];
    this.outputs = new ArrayList<String>();
  }
}

class AND extends Gate {
  AND() {
    super(2); // An AND gate has 2 inputs
  }

  boolean _compute(boolean[] inputs) {
    return inputs[0] & inputs[1];
  }
}
