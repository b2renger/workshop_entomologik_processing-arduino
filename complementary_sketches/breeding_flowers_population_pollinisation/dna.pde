class Dna{
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
  
  float[] genome;

  Dna(){
    genome = randomDNA();
  }
  
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
  float[] randomDNA() {
    float[] result= new float[11];
    for (int i = 0; i < 11; i++) {
      result[i]= randomGene(i);
    }
    return result;
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

  
  
}