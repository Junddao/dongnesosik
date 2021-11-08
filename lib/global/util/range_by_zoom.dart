class RangeByZoom {
  static int getRangeByZooom(double zoom) {
    int range = 1500;

    if (zoom < 1) {
      range = 24576000;
    } else if (zoom < 2) {
      range = 12288000;
    } else if (zoom < 3) {
      range = 6144000;
    } else if (zoom < 4) {
      range = 3072000;
    } else if (zoom < 5) {
      range = 1536000;
    } else if (zoom < 6) {
      range = 768000;
    } else if (zoom < 7) {
      range = 384000;
    } else if (zoom < 8) {
      range = 192000;
    } else if (zoom < 9) {
      range = 96000;
    } else if (zoom < 10) {
      range = 48000;
    } else if (zoom < 11) {
      range = 24000;
    } else if (zoom < 12) {
      range = 12000;
    } else if (zoom < 13) {
      range = 6000;
    } else if (zoom < 14) {
      range = 3000;
    } else if (zoom < 15) {
      range = 1500;
    } else if (zoom < 16) {
      range = 750;
    } else if (zoom < 17) {
      range = 375;
    } else if (zoom < 18) {
      range = 188;
    } else if (zoom < 19) {
      range = 94;
    } else if (zoom < 20) {
      range = 47;
    } else if (zoom < 21) {
      range = 23;
    }
    return range;
  }
}
