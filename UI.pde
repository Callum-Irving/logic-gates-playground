import java.util.Iterator;

class UiState {
  String selectedId = null;
  Gate selected = null;
  boolean connecting = false;

  Circuit circuit;

  UiState(Circuit circuit) {
    this.circuit = circuit;
    this.circuit.compute();
  }

  void clicked() {
    for (Gate g : this.circuit.gates.values()) {
      if (g.pointTouching(mouseX, mouseY)) {
        g.clicked();
        this.circuit.compute();
        redraw();
      }
    }
  }

  // TODO: Move some of this to circuit class
  void deleteGate() {
    for (Iterator<Map.Entry<String, Gate>> it = this.circuit.gates.entrySet().iterator(); it.hasNext(); ) {
      Map.Entry<String, Gate> entry = it.next();
      if (entry.getValue().pointTouching(mouseX, mouseY)) {
        for (Gate input : entry.getValue().inputs) {
          if (input == null) continue;
          input.connections.removeIf(c -> c.destId == entry.getKey());
        }
        it.remove();
      }
    }

    this.circuit.compute();
    redraw();
  }

  void select() {
    for (String id : this.circuit.gates.keySet()) {
      Gate g = this.circuit.gates.get(id);
      if (g.overOutput(mouseX, mouseY)) {
        this.selectedId = id;
        this.selected = g;
        this.connecting = true;
        return;
      } else if (g.pointTouching(mouseX, mouseY)) {
        this.selected = g;
        return;
      }
    }
  }

  void deselect() {
    if (this.connecting) {
      for (String id : this.circuit.gates.keySet()) {
        Gate g = this.circuit.gates.get(id);
        int inputNum = g.overInput(mouseX, mouseY);
        if (inputNum != -1) {
          // Delete existing connection
          Gate dest = this.circuit.gates.get(id);
          if (dest.inputs[inputNum] == this.selected) {
            dest.removeInput(inputNum);
          } else {
            dest.removeInput(inputNum);
            this.circuit.addConnection(this.selectedId, id, inputNum);
          }
        }
      }
      this.connecting = false;
      this.circuit.compute();
    }
    this.selected = null;
    this.selectedId = null;
    redraw();
  }

  void dragged() {
    if (selected != null) {
      if (!connecting) {
        selected.x = mouseX;
        selected.y = mouseY;
      }
    }
    redraw();
  }

  void show() {
    for (Gate g : this.circuit.gates.values()) {
      g.show();
    }

    for (Gate g : this.circuit.gates.values()) {
      g.showConnections();
    }

    if (connecting) {
      stroke(20, 20, 255);
      strokeWeight(5);
      PVector p1 = selected.outputPos();
      line(p1.x, p1.y, mouseX, mouseY);
    }
  }

  void createGate(char c) {
    switch (c) {
    case 'a':
      this.circuit.addGate(new AndGate(mouseX, mouseY));
      break;
    case 'n':
      this.circuit.addGate(new NotGate(mouseX, mouseY));
      break;
    case '1':
      this.circuit.addInput();
      break;
    case '2':
      this.circuit.addOutput();
      break;
    case 'x':
      this.circuit.addGate(new XorGate(mouseX, mouseY));
      break;
    case 'o':
      this.circuit.addGate(new OrGate(mouseX, mouseY));
      break;
    case 'A':
      this.circuit.addGate(new NandGate(mouseX, mouseY));
      break;
    case 'O':
      this.circuit.addGate(new NorGate(mouseX, mouseY));
      break;
    case 'X':
      this.circuit.addGate(new XnorGate(mouseX, mouseY));
      break;
    }
    redraw();
  }
}
