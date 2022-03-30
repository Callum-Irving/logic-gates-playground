// TODO: Sort out access modifiers

abstract class Gate {
  int x, y; // For displaying on screen
  String[] inputs;
  // TODO: Make output an arraylist so that one output can connect to multiple things
  String output;
  HashSet<String> outputs;

  int numInputs;
  abstract boolean _compute(boolean[] inputs);

  boolean compute(boolean[] inputs) {
    assert(inputs.length == this.numInputs);
    return this._compute(inputs);
  }


  Gate(int n) {
    this.numInputs = n;
    this.inputs = new String[n];
    this.outputs = new HashSet<String>();
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
