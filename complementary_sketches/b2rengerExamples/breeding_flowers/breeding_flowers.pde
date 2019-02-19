/* how to ?
   The sketch show two parents and a child. The drawing characteristics of each parent is given in a genome (an array of floats), the child is bred by manipulating 
   the arrays of each parent to combine it in a new one.
   Press the keyboard to generate a new child.
   Edit the arrays 'genome1' and 'genome2' to create new parents according to the "DataNucleic" Model


/* ideas to go further :
   *graphic/genome tweaks : add a stem with a number of leaves on it
   *implement some mutations => order the genes by importance : a higly mutagen environnement will mutate important genes, a low mutagen envrionnement would mutate lowest ranked genes.
   *allow several types of cross-breeding (color factors from one / form factors from 2 etc...), 
   *generate an array of genomes to build a population based on several parents given by each student in the class
   *make the population evolve :  two individual share one characterstic they can breed (it will narrow the outcom) / or if they are close enough 
*/

/* leads for telling the story in class :
  * Gather ideas about how to draw a flower steering them to the idea of a center and two rows of petals
  * Gather ideas about DNA ? genes ? Why do we look like our parents ?
  * Steer toward the discussion about a data model of genes to draw a flower, you can implement the enum type list of variables
  * Once its done, each one can create a flower choosing values for the data model and implementing a genome array
  * Now we need to write the breeding functions : lots of options here ...
  * Once its done we gather the genomes use the breeding function to draw offsprings
*/


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


float[] child = new float[15];

void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

  child = breeding(genome1, genome2);
}

void draw() {
  background(0);

  drawFlower(width/3, height/3, genome1);
  drawFlower(width*2/3, height/3, genome2);
  drawFlower(width/2, height*2/3, child);
}

void keyPressed() {
  child = breeding(genome1, genome2);
}


float[] breeding(float[] parent1, float[] parent2) {
  float [] newgenes = new float [parent1.length];
  for (int i = 0; i < parent1.length; i++) {
    if (random(100)<50) {
      newgenes[i] = parent1[i];
    } else {
      newgenes[i] = parent2[i];
    }
  }
  return newgenes;
}


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

