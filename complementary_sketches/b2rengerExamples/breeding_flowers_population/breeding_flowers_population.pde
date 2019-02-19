/* how to ? //<>//
This sketch features a mother flower and a population. 
Each member of the populatiopn breeds by polinisation with the mother.
You can change the features of the mother by fiddling with the sliders.
 
 */
 
 /*
 add key shortcuts to switch functions
 
 */


/* DNM
 genome Data Model
 - center size
 - center fillHue
 - center opacity
 
 - nb petal 1st row
 - petal size
 - 1st row fillHue
 - 1st row opacity
 
 
 - nb petal 2nd row
 - 2nd row fillHue
 - 2nd row opacity
 
 */

float[] genome1 = new float[] {
  50, 88, 50, // center
  17, 50, 152, 10, //1st row
  11, 50, 300, 20//2nd row
};

HScrollbar[] sliders = new HScrollbar[genome1.length];

int pop_count = 128;
float[][] population = new float[pop_count][11] ; // an array of genome

int index = 0;

void setup() {
  size(1600, 1000);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

  for (int i = 0; i < pop_count; i++) {
    population[i] = randomFlower();
  }

  for (int i = 0; i < sliders.length; i ++) {
    int xpos = 300 + (i%4)*250;
    int ypos = 50 + int(i/4)*50;
    sliders[i] = new HScrollbar(xpos, ypos, 200, 20, genenames[i],genome1[i]);
  }
}

void draw() {
  background(0, 0, 100);
  rectMode(CORNER);
  // draw the mother of all flowers
  scale(1, 1);
  float xpos = 100;
  float ypos =80;
  drawFlower(xpos, ypos, genome1);

  for (int i = 0; i < sliders.length; i ++) {
    sliders[i].update();
    sliders[i].display();
    println(sliders[i].getPos());
    
    if (i == centerSize || i == firstSize || i == secondSize) {
      genome1[i] =  map(sliders[i].getPos(),0,1,20, 60); // it's a size param
    } else if (i == centerFillHue || i == firstFillHue || i ==secondFillHue) {
      genome1[i] =  map(sliders[i].getPos(),0,1,0, 360);// it's a hue param
    } else if (i == centerOpacity || i == firstOpacity || i == secondOpacity) {
      genome1[i] = map(sliders[i].getPos(),0,1,5, 80); // it's an opacity param
    } else if (i == firstNumber || i == secondNumber ) {
      genome1[i] = int(map(sliders[i].getPos(),0,1,5, 25)); // it's a quantity param
    }
  }

  // draw the population
  scale(0.5, 0.5);
  for (int i = 0; i < pop_count; i++) { 
    xpos = 100 + (i%16)*200;
    ypos = 500 + int(i/16)*200;
    drawFlower(xpos, ypos, population[i]);
  }


  if (frameCount%2 == 0) {
    index +=1;
    index = index%pop_count;
    population[index] = breeding_mutation(population[index], genome1);
  }

  //scale(1,1);
  float ex = 100+ (index%16)*200;
  float wy = 500+ int(index/16)*200;
  noFill();
  stroke(0, 0, 0);
  rectMode(CENTER);
  rect(ex, wy, 200, 200);
}

void keyPressed() {
  for (int i = 0; i < pop_count; i++) {
    population[i] = randomFlower();
  }
}


float[] breeding_mutation(float[] parent1, float[] parent2) {
  float [] newgenes = new float [parent1.length];
  for (int i = 0; i < parent1.length; i++) {
    float val = random(100);
    if (val<45) {
      newgenes[i] = parent1[i];
    } else if (val <99) {
      newgenes[i] = parent2[i];
    } else {
      // one percent chance a gene mutates into a random value
      newgenes[i] = randomGene(i);
    }
  }
  return newgenes;
}



float[] breeding(float[] parent1, float[] parent2) {
  float [] newgenes = new float [parent1.length];
  for (int i = 0; i < parent1.length; i++) {
    float val = random(100);
    if (val<50) {
      newgenes[i] = parent1[i];
    } else {
      newgenes[i] = parent2[i];
    }
  }
  return newgenes;
}


// enum type like way to adress arrays indexes
// this is usefull to deal with names instead of numbers and make the code below more readable
int centerSize = 0;
int centerFillHue = 1;
int centerOpacity = 2;

int firstNumber = 3;
int firstSize = 4;
int firstFillHue = 5;
int firstOpacity = 6;

int secondNumber = 7;
int secondSize = 8;
int secondFillHue = 9;
int secondOpacity = 10;

String[] genenames = { "center size", "center hue", "center opacity", 
  "first corol number", "first corol petal size", "first corol hue", "first corol opacity", 
  "second corol number", "second corol petal size", "second corol hue", "second corol opacity"
};

// a function to return a scaled value for each type of gene
float randomGene(int index) {
  float result =0;
  if (index == centerSize || index == firstSize || index == secondSize) {
    result = random(20, 60); // it's a size param
  } else if (index == centerFillHue || index == firstFillHue || index ==secondFillHue) {
    result = random(0, 360); // it's a hue param
  } else if (index == centerOpacity || index == firstOpacity || index == secondOpacity) {
    result = random(5, 80); // it's an opacity param
  } else if (index == firstNumber || index == secondNumber ) {
    result = int(random(5, 25)); // it's a quantity param
  }
  return result;
}

// a function to return a new random genome
float[] randomFlower() {
  float[] result= new float[11];
  for (int i = 0; i < 11; i++) {
    result[i]= randomGene(i);
  }
  return result;
}

// draw a flower with a given genome
void drawFlower( float xpos, float ypos, float[] genome ) {

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