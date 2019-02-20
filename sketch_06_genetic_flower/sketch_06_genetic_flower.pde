

/* DNM
genome Data Model
 - center size
 - center fillHue
 - center opacity
 - center strokeHue
 - center strokeWeight
 
 - nb petal 1st row
 - petal size
 - 1st row fillHue
 - 1st row opacity
 - 1st row strokeHue
 - 1st row strokeWeight
 
 - nb petal 2nd row
 - 2nd row fillHue
 - 2nd row opacity
 - 2nd row strokeHue
 - 2nd row strokeWeight
 */
 
 // enum type like way to adress arrays indexes
int centerSize = 0;
int centerFillHue = 1;
int centerOpacity = 2;
int centerStrokeHue = 3;
int centerStrokeWeight = 4;
int firstNumber = 5;
int firstSize = 6;
int firstFillHue = 7;
int firstOpacity = 8;
int firstStrokeHue = 9;
int firstStrokeWeight = 10;
int secondNumber = 11;
int secondSize = 12;
int secondFillHue = 13;
int secondOpacity = 14;
int secondStrokeHue = 15;
int secondStrokeWeight = 16;

 
float[] genome1 = new float[] {
  50, 88, 50, 12, 5, // center
  17, 50, 152, 10, 152, 0.5, //1st row
  11, 50, 300, 20, 128, 0.5 //2nd row
};

float[] genome2 = new float[] {
  75, 88, 50, 12, 8, 
  5, 40, 55, 15, 55, 5, 
  9, 70, 5, 25, 5, 2
};



void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

}

void draw() {
  background(0);

  drawFlower(width/3, height/3, genome1);
  drawFlower(width*2/3, height/3, genome2);
}





// this can be copied/pasted
// draw a flower with a given genome
void drawFlower( float xpos, float ypos, float[] genome ) {

  pushMatrix();
  pushStyle();
  translate(xpos, ypos);

  // first draw the second row (in the back)
  for (int i = 0; i < int (genome[secondNumber]); i++) {
    fill(genome[secondFillHue], 100, 100, genome[secondOpacity]);
    stroke (genome[secondStrokeHue], 100, 100, genome[secondOpacity]);
    strokeWeight(genome[secondStrokeWeight]);

    float x = cos(i*(TWO_PI )/genome[secondNumber])*genome[centerSize];
    float y = sin(i*(TWO_PI)/genome[secondNumber])*genome[centerSize];
    float rad = genome[secondSize];
    ellipse(x, y, rad, rad);
  }
  // then the second one
  for (int i = 0; i < int (genome[firstNumber]); i++) {
    fill(genome[firstFillHue], 100, 100, genome[firstOpacity]);
    stroke (genome[firstStrokeHue], 100, 100, genome[firstOpacity]);
    strokeWeight(genome[firstStrokeWeight]);

    float x = cos(i*(TWO_PI)/genome[firstNumber])*genome[centerSize]/2;
    float y = sin(i*(TWO_PI)/genome[firstNumber])*genome[centerSize]/2;
    float rad = genome[firstSize];
    ellipse(x, y, rad, rad);
  }
  // finally the center
  fill(genome[centerFillHue], 100, 100, genome[centerOpacity]);
  stroke (genome[centerStrokeHue], 100, 100, genome[centerOpacity]);
  strokeWeight(genome[centerStrokeWeight]);
  ellipse(0, 0, genome[centerSize], genome[centerSize]);

  popStyle();
  popMatrix();
}
