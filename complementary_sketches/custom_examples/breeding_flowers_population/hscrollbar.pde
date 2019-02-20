// from http://processingjs.org/learning/topic/scrollbar/


class HScrollbar

{

  int swidth, sheight;    // width and height of bar

  int xpos, ypos;         // x and y position of bar

  float spos, newspos;    // x position of slider

  int sposMin, sposMax;   // max and min values of slider

  int loose;              // how loose/heavy

  boolean over;           // is the mouse over the slider?

  boolean locked;

  float ratio;

  String label;


  HScrollbar (int xp, int yp, int sw, int sh, String label, float val) {

    swidth = sw;

    sheight = sh;

    int widthtoheight = sw - sh;

    ratio = (float)sw / (float)widthtoheight;

    xpos = xp;

    ypos = yp-sheight/2;

    spos = xpos + val;

    newspos = spos;

    sposMin = xpos;

    sposMax = xpos + swidth - sheight;

    loose = 10;

    this.label = label;
  }



  void update() {

    if (over()) {

      over = true;
    } else {

      over = false;
    }

    if (mousePressed && over) {

      locked = true;
    }

    if (!mousePressed) {

      locked = false;
    }

    if (locked) {

      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }

    if (abs(newspos - spos) > 1) {

      spos = spos + (newspos-spos)/loose;
    }
  }



  int constrain(int val, int minv, int maxv) {

    return min(max(val, minv), maxv);
  }



  boolean over() {

    if (mouseX > xpos && mouseX < xpos+swidth &&

      mouseY > ypos && mouseY < ypos+sheight) {

      return true;
    } else {

      return false;
    }
  }



  void display() {

    pushMatrix();
    fill(255, 0, 25);

    text(label, xpos, ypos-10);
    rect(xpos, ypos, swidth, sheight, 5);

    if (over || locked) {
      fill(102, 0, 102);
    } else {
      fill(153, 102, 0);
    }
    fill(255, 0, 90);
    rect(spos, ypos, sheight, sheight, 5);
    popMatrix();
  }



  float getPos() {

    // Convert spos to be values between

    // 0 and the total width of the scrollbar

    return (spos-xpos)/swidth;
  }
}