byte[] genPad(byte[] b) { //generates a random string of bytes of the same length as the given string
  byte[] p = new byte[b.length];
  for (int i = 0; i < p.length; i++) {
    p[i] = byte(random(0, 255));
  }
  return p;
}

byte[] encrypt(byte[] b, byte[] pad) { //XORs the given pad with the given list of byes (ascii)
  byte[] encrypted = new byte[b.length];
  for (int i = 0; i < b.length; i++) {
    encrypted[i] = byte((b[i] ^ pad[i]));
  }
  return encrypted;
}
