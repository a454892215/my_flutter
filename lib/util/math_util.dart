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

  static int mode(num v) {
    if (v > 0) {
      return 1;
    } else if (v < 0) {
      return -1;
    }
    return 0;
  }

  static num abs(num v) {
    if(v < 0) return -v;
    return v;
  }
}
