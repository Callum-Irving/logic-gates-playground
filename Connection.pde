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
}
