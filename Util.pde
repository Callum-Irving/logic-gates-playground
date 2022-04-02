float distance(float x1, float y1, float x2, float y2) {
  float distX = x1 - x2;
  float distY = y1 - y2;
  return (sqrt(distX * distX + distY * distY));
}
