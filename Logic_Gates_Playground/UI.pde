import java.util.Iterator;

class UiState {
  float xOff = 0, yOff =0;
  float scale = 1.0;
  boolean[] keys = new boolean[4];

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
      if (g.pointTouching(this.mouseX(), this.mouseY())) {
        g.clicked();
        this.circuit.compute();
      }
    }
  }

  void deleteGate() {
    for (Map.Entry<String, Gate> entry : this.circuit.gates.entrySet()) {
      // Remove gate touching mouse
      if (entry.getValue().pointTouching(this.mouseX(), this.mouseY())) {
        this.circuit.removeGate(entry.getKey());
        break;
      }
    }
  }

  void select() {
    for (String id : this.circuit.gates.keySet()) {
      Gate g = this.circuit.gates.get(id);
      if (g.overOutput(this.mouseX(), this.mouseY())) {
        this.selectedId = id;
        this.selected = g;
        this.connecting = true;
        return;
      } else if (g.pointTouching(this.mouseX(), this.mouseY())) {
        this.selected = g;
        return;
      }
    }
  }

  void deselect() {
    if (this.connecting) {
      for (String id : this.circuit.gates.keySet()) {
        Gate g = this.circuit.gates.get(id);
        int inputNum = g.overInput(this.mouseX(), this.mouseY());
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
  }

  void dragged() {
    if (mousePressed && mouseButton == CENTER) {
      // Pan using middle mouse button
      // Can be changed to right click if you don't have a middle mouse button
      xOff -= (pmouseX - mouseX) / this.scale;
      yOff -= (pmouseY - mouseY) / this.scale;
    } else if (selected != null) {
      // Move the gate under the mouse
      if (!connecting) {
        selected.x = int(this.mouseX());
        selected.y = int(this.mouseY());
      }
    }
  }

  void show() {
    push();
    scale(this.scale);
    translate(this.xOff, this.yOff);

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
      line(p1.x, p1.y, this.mouseX(), this.mouseY());
    }
    pop();
  }

  void keyDown() {
    switch (key) {
    case 'l':
      selectInput("Load a JSON file:", "loadUiJSON");
      break;
    case 's':
      selectInput("Pick a file to save data to:", "saveUiJSON");
      break;
    case '1':
      this.circuit.addGate(new InputGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case '2':
      this.circuit.addGate(new OutputGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'a':
      this.circuit.addGate(new AndGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'A':
      this.circuit.addGate(new NandGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'n':
      this.circuit.addGate(new NotGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'o':
      this.circuit.addGate(new OrGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'O':
      this.circuit.addGate(new NorGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'x':
      this.circuit.addGate(new XorGate(int(this.mouseX()), int(this.mouseY())));
      break;
    case 'X':
      this.circuit.addGate(new XnorGate(int(this.mouseX()), int(this.mouseY())));
      break;
    }
  }

  void keyUp() {
    switch (keyCode) {
    case LEFT:
      this.keys[0] = false;
      break;
    case RIGHT:
      this.keys[1] = false;
      break;
    case UP:
      this.keys[2] = false;
      break;
    case DOWN:
      this.keys[3] = false;
      break;
    }
  }

  void zoom(float value) {
    float prevX = this.mouseX();
    float prevY = this.mouseY();
    if (value < 0) {
      ui.scale *= 1.2;
    } else if (value > 0) {
      ui.scale /= 1.2;
    }
    this.xOff -= (prevX - this.mouseX());
    this.yOff -= (prevY - this.mouseY());
  }

  float mouseX() {
    return mouseX / this.scale - this.xOff;
  }

  float mouseY() {
    return mouseY / this.scale - this.yOff;
  }
}
