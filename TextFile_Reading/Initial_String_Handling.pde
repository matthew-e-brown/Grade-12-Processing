char[] byteToChar(byte[] b) {
  char[] c = new char[b.length];
  for (int i = 0; i < b.length; i++) {
    c[i] = char(b[i]);
  }
  return c;
}

String charsToString(char[] c) {
  String[] s = new String[c.length];
  for (int i = 0; i < c.length; i++) {
    s[i] = str(c[i]);
  }
  String all = join(s, "");
  return all;
}

String[] charsToLines(char[] c) {
  String allS = charsToString(c);
  String[] l = split(allS, '\n');
  return l;
}
