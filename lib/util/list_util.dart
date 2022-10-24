class ListU {

 static List<int> fillRange([int start = 0, int end = 10]) {
    List<int> ls = [];
    for (int i = start; i <= end; i++) {
      ls.add(i);
    }
    return ls;
  }

}
