class Bee extends Dna {
  float xpos = width;
  float ypos = height;
  float xtarget = width;
  float ytarget = height;
  boolean hasPollen = false;


  Bee() {
    super();
  }



  void move() {
    xpos += min((xtarget-xpos)*0.15,10);
    ypos += min((ytarget-ypos)*0.15,10);
  }

  void updateTarget(float newX, float newY) {
    xtarget = newX;
    ytarget = newY;
  }

  float[] getPollenDNA() { 
    return genome;
  }

  void setPollenDNA(float [] newPollen) {
    genome = newPollen;
  }

  void draw() {
    //noStroke();
    //fill(0);
    // ellipse(xpos,ypos,15,15);
    pushMatrix();

    drawFlower();
    popMatrix();
  }


  void drawFlower( ) {

    pushMatrix();
    pushStyle();
    translate(xpos, ypos);
    scale(0.5);
    // first draw the second row (in the back)
    for (int i = 0; i < int (genome[secondNumber]); i++) {
      fill(genome[secondFillHue], 80, 100, genome[secondOpacity]);
      noStroke();

      float x = cos(i*(TWO_PI )/genome[secondNumber])*genome[centerSize];
      float y = sin(i*(TWO_PI)/genome[secondNumber])*genome[centerSize];
      float rad = genome[secondSize];
      ellipse(x, y, rad, rad);
    }
    // then the second one
    for (int i = 0; i < int (genome[firstNumber]); i++) {
      fill(genome[firstFillHue], 80, 100, genome[firstOpacity]);

      float x = cos(i*(TWO_PI)/genome[firstNumber])*genome[centerSize]/2;
      float y = sin(i*(TWO_PI)/genome[firstNumber])*genome[centerSize]/2;
      float rad = genome[firstSize];
      ellipse(x, y, rad, rad);
    }
    // finally the center
    fill(genome[centerFillHue], 80, 100, genome[centerOpacity]);
    ellipse(0, 0, genome[centerSize], genome[centerSize]);

    popStyle();
    popMatrix();
  }
}