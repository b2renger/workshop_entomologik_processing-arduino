
class Flower extends Dna {
  float xpos, ypos;
  

  Flower(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  float[] getFlowerDNA(){ 
    return genome;
  }
  
  void setFlowerDNA(float [] newGenome){
    genome = newGenome;
  }


  // draw a flower with a given genome
  void drawFlower( ) {

    pushMatrix();
    pushStyle();
    translate(xpos, ypos);

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