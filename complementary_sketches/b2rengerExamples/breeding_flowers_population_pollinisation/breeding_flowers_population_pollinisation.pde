 //<>//

/* how to ?
 This sketch features a mother flower and a population. 
 Each member of the populatiopn breeds by polinisation with the mother.
 You can change the features of the mother by fiddling with the sliders.
 
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

int pop_count = 320;
Flower[] population = new Flower[pop_count] ; // an array of genome
float incr = random(500);
int index=0;

Bee[] bees = new Bee[10];

boolean showBees = true;

void setup() {
  size(1600, 1000,P2D);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

  for (int i = 0; i < pop_count; i++) {
    float xpos = 100 + (i%32)*200;
    float ypos = 100 + int(i/32)*200;
    population[i] = new Flower(xpos, ypos);
  }

  for (int i = 0; i < bees.length; i++) {
    bees[i] = new Bee();
  }
}

void draw() {
  background(0, 0, 100);
  rectMode(CORNER);
  scale(0.25, 0.25);  
  for (int i = 0; i < bees.length; i++) {
    bees[i].move();
    if (showBees)bees[i].draw();

    if (dist(bees[i].xpos, bees[i].ypos, bees[i].xtarget, bees[i].ytarget)<5) {
      // find the flower close to the bee
      for (int j = 0; j < pop_count; j++) {
        if (dist(population[j].xpos, population[ j].ypos, bees[i].xtarget, bees[i].ytarget) ==0) {
          float[] pollen = bees[i].getPollenDNA();
          float[] dna = population[j].getFlowerDNA();
          population[j].setFlowerDNA( population[i].breeding_mutation(pollen, dna));

          bees[i].setPollenDNA( population[j].genome);
        }
      }


      float newTarget = int(random(pop_count));
      float newX = 100+(newTarget%32)*200;
      float newY = 100+int(newTarget/32)*200;
      bees[i].updateTarget(newX, newY);
    }
  }

  // draw the population

  for (int i = 0; i < pop_count; i++) { 
    population[i].drawFlower();
  }
}

void keyPressed() {

  if (key =='b' || key == 'B') {
    showBees = !showBees;
  } else {
    for (int i = 0; i < pop_count; i++) {
      float xpos = 100 + (i%32)*200;
      float ypos = 100 + int(i/32)*200;
      population[i] = new Flower(xpos, ypos);
    }
  }
}
