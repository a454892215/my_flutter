class MathU {
  static String to2D(double value) {
    return value.toStringAsPrecision(2);
  }

  static double clamp(double value, double min, double max) {
    if (value > max) {
      return max;
    }
    if (value < min) {
      return min;
    }
    return value;
  }
}
