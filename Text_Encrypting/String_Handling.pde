//These are all fairly self explanatory. They are used to make it easier to display lists of bytes in textblocks.

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

String byteToString(byte[] b) {
  char[] c = byteToChar(b);
  String s = charsToString(c);
  return s;
}
