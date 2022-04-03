class Connection {
  Gate src, dest;
  String srcId, destId;
  int destIndex;

  Connection(String srcId, Gate src, String destId, Gate dest, int destIndex) {
    this.srcId = srcId;
    this.src = src;
    this.destId = destId;
    this.dest = dest;
    this.destIndex = destIndex;
  }

  void show() {
    if (this.src.output)
      stroke(235, 235, 52);
    else
      stroke(0);
    strokeWeight(5);
    PVector src = this.src.outputPos();
    PVector dest = this.dest.inputPos(this.destIndex);
    line(src.x, src.y, dest.x, dest.y);
  }
}
