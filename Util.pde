float distance(float x1, float y1, float x2, float y2) {
  float distX = x1 - x2;
  float distY = y1 - y2;
  return (sqrt(distX * distX + distY * distY));
}

class JSONConnection {
  String src;
  String dest;
  int destIndex;

  JSONConnection(String src, String dest, int destIndex) {
    this.src = src;
    this.dest = dest;
    this.destIndex = destIndex;
  }
}

void loadJSON(File input) {
  if (input == null) return;

  Circuit circuit = new Circuit();

  JSONObject json = loadJSONObject(input.getAbsolutePath());

  JSONArray gates = json.getJSONArray("gates");
  ArrayList<JSONConnection> connections = new ArrayList<JSONConnection>();

  for (int i = 0; i < gates.size(); i++) {
    JSONObject gate = gates.getJSONObject(i);
    String name = gate.getString("name");
    String type = gate.getString("type");
    int x = gate.getInt("x");
    int y = gate.getInt("y");
    Gate g = createGate(type, x, y);
    if (g instanceof InputGate) {
      boolean value = gate.getBoolean("output");
      ((InputGate)g).setVal(value);
    }
    circuit.addGate(name, g);
    JSONArray cons = gate.getJSONArray("connections");
    for (int j = 0; j < cons.size(); j++) {
      JSONObject connection = cons.getJSONObject(j);
      String dest = connection.getString("destId");
      int destIndex = connection.getInt("destIndex");
      connections.add(new JSONConnection(name, dest, destIndex));
    }
  }

  for (JSONConnection connection : connections) {
    circuit.addConnection(connection.src, connection.dest, connection.destIndex);
  }

  // This code reads and updates ui state
  //float xOff = json.getFloat("xOff");
  //float yOff = json.getFloat("yOff");
  //float scale = json.getFloat("scale");
  //ui.xOff = xOff;
  //ui.yOff = yOff;
  //ui.scale = scale;

  ui.circuit = circuit;
}

Gate createGate(String type, int x, int y) {
  switch (type) {
  case "input":
    return new InputGate(x, y);
  case "output":
    return new OutputGate(x, y);
  case "AND":
    return new AndGate(x, y);
  case "NAND":
    return new NandGate(x, y);
  case "OR":
    return new OrGate(x, y);
  case "NOR":
    return new NorGate(x, y);
  case "XOR":
    return new XorGate(x, y);
  case "XNOR":
    return new XnorGate(x, y);
  case "NOT":
    return new NotGate(x, y);
  default:
    return null;
  }
}

void saveJSON(File output) {
  JSONObject json = new JSONObject();

  JSONArray gates = new JSONArray();
  for (Map.Entry<String, Gate> entry : ui.circuit.gates.entrySet()) {
    JSONObject gate = new JSONObject();
    gate.setString("name", entry.getKey());

    Gate g = entry.getValue();
    if (g instanceof InputGate) {
      gate.setString("type", "input");
      gate.setBoolean("output", g.output);
    } else if (g instanceof OutputGate) {
      gate.setString("type", "output");
    } else if (g instanceof AndGate) {
      gate.setString("type", "AND");
    } else if (g instanceof NandGate) {
      gate.setString("type", "NAND");
    } else if (g instanceof OrGate) {
      gate.setString("type", "OR");
    } else if (g instanceof NorGate) {
      gate.setString("type", "NOR");
    } else if (g instanceof XorGate) {
      gate.setString("type", "XOR");
    } else if (g instanceof XnorGate) {
      gate.setString("type", "XNOR");
    } else if (g instanceof NotGate) {
      gate.setString("type", "NOT");
    }

    gate.setInt("x", g.x);
    gate.setInt("y", g.y);

    JSONArray connections = new JSONArray();
    for (Connection c : g.connections) {
      JSONObject connection = new JSONObject();
      connection.setString("destId", c.destId);
      connection.setInt("destIndex", c.destIndex);
      connections.append(connection);
    }

    gate.setJSONArray("connections", connections);

    gates.append(gate);
  }

  json.setJSONArray("gates", gates);

  saveJSONObject(json, output.getAbsolutePath());
}
