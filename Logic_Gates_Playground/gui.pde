/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.
 
 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
 // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:867302:
  appc.background(230);
} //_CODE_:window1:867302:

public void resetButtonClicked(GButton source, GEvent event) { //_CODE_:resetButton:610620:
  ui = new UiState();
} //_CODE_:resetButton:610620:

public void saveButtonClicked(GButton source, GEvent event) { //_CODE_:saveButton:610189:
  selectInput("Pick a file to save data to:", "saveUiJSON");
} //_CODE_:saveButton:610189:

public void loadButtonClicked(GButton source, GEvent event) { //_CODE_:loadButton:309090:
  selectInput("Load a JSON file:", "loadUiJSON");
} //_CODE_:loadButton:309090:

public void inputButtonClicked(GButton source, GEvent event) { //_CODE_:inputButton:506805:
  ui.addGate(new InputGate());
} //_CODE_:inputButton:506805:

public void andButtonClicked(GButton source, GEvent event) { //_CODE_:andButton:284474:
  ui.addGate(new AndGate());
} //_CODE_:andButton:284474:

public void nandButtonClicked(GButton source, GEvent event) { //_CODE_:nandButton:615245:
  ui.addGate(new NandGate());
} //_CODE_:nandButton:615245:

public void outputButtonClicked(GButton source, GEvent event) { //_CODE_:outputButton:362842:
  ui.addGate(new OutputGate());
} //_CODE_:outputButton:362842:

public void orButtonClicked(GButton source, GEvent event) { //_CODE_:orButton:562065:
  ui.addGate(new OrGate());
} //_CODE_:orButton:562065:

public void norButtonClicked(GButton source, GEvent event) { //_CODE_:norButton:380732:
  ui.addGate(new NorGate());
} //_CODE_:norButton:380732:

public void notButtonClicked(GButton source, GEvent event) { //_CODE_:notButton:695591:
  ui.addGate(new NotGate());
} //_CODE_:notButton:695591:

public void xorButtonClicked(GButton source, GEvent event) { //_CODE_:xorButton:944756:
  ui.addGate(new XorGate());
} //_CODE_:xorButton:944756:

public void xnorButtonClicked(GButton source, GEvent event) { //_CODE_:xnorButton:230968:
  ui.addGate(new XnorGate());
} //_CODE_:xnorButton:230968:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Controls", 0, 0, 300, 300, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  resetButton = new GButton(window1, 205, 90, 80, 30);
  resetButton.setText("Reset");
  resetButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  resetButton.addEventHandler(this, "resetButtonClicked");
  saveButton = new GButton(window1, 15, 90, 80, 30);
  saveButton.setText("Save");
  saveButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  saveButton.addEventHandler(this, "saveButtonClicked");
  loadButton = new GButton(window1, 110, 90, 80, 30);
  loadButton.setText("Load");
  loadButton.addEventHandler(this, "loadButtonClicked");
  inputButton = new GButton(window1, 15, 160, 80, 30);
  inputButton.setText("Add Input");
  inputButton.addEventHandler(this, "inputButtonClicked");
  andButton = new GButton(window1, 15, 200, 80, 30);
  andButton.setText("AND Gate");
  andButton.addEventHandler(this, "andButtonClicked");
  nandButton = new GButton(window1, 15, 240, 80, 30);
  nandButton.setText("NAND Gate");
  nandButton.addEventHandler(this, "nandButtonClicked");
  outputButton = new GButton(window1, 110, 160, 80, 30);
  outputButton.setText("Add Output");
  outputButton.addEventHandler(this, "outputButtonClicked");
  orButton = new GButton(window1, 110, 200, 80, 30);
  orButton.setText("OR Gate");
  orButton.addEventHandler(this, "orButtonClicked");
  norButton = new GButton(window1, 110, 240, 80, 30);
  norButton.setText("NOR Gate");
  norButton.addEventHandler(this, "norButtonClicked");
  notButton = new GButton(window1, 205, 160, 80, 30);
  notButton.setText("NOT Gate");
  notButton.addEventHandler(this, "notButtonClicked");
  xorButton = new GButton(window1, 205, 200, 80, 30);
  xorButton.setText("XOR Gate");
  xorButton.addEventHandler(this, "xorButtonClicked");
  xnorButton = new GButton(window1, 205, 240, 80, 30);
  xnorButton.setText("XNOR Gate");
  xnorButton.addEventHandler(this, "xnorButtonClicked");
  heading = new GLabel(window1, 50, 10, 200, 30);
  heading.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  heading.setText("Logic Gates Control Panel");
  heading.setOpaque(false);
  label1 = new GLabel(window1, 35, 50, 86, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Scroll to zoom");
  label1.setOpaque(false);
  label2 = new GLabel(window1, 135, 50, 134, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Shift + left click to drag");
  label2.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GButton resetButton; 
GButton saveButton; 
GButton loadButton; 
GButton inputButton; 
GButton andButton; 
GButton nandButton; 
GButton outputButton; 
GButton orButton; 
GButton norButton; 
GButton notButton; 
GButton xorButton; 
GButton xnorButton; 
GLabel heading; 
GLabel label1; 
GLabel label2; 