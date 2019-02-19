/*
https://www.openprocessing.org/sketch/598560
Venation 2D by Patrick Bedarf
www.bedarf.cc

References:
https://inconvergent.net/generative/hyphae/
https://n-e-r-v-o-u-s.com/projects/content/poster-reaction-diffusion-2/
Runions, A. et al (2005) "Modeling and Visualization of Leaf Venation Patterns"
*/


ArrayList<Node> seeds = new ArrayList<Node>();
Vein vein;
int r, seedPop;
float worldRecord;
Node s;
IntList kills;

void setup() {
  r = 200;
  seedPop = 100;
  size(580, 580);
  init();
  vein = new Vein(height/2, width/2);
}

void draw() {
  background(240);
  smooth();
  vein.update();
  for (Node seed : seeds) {
    seed.display();
  }
  //text("Seed No " + seeds.size(), 20, height-20);
  //text("Node No " + vein.nodes.size(), 20, height-40);
  if (seeds.size() < 1) {
    //saveFrame("Ven2D_V1_#####.png");
    noLoop();
  }
}

void mouseReleased() {
  init();
}

void init() {
  loop();
  seeds.clear();
  for (int i = 0; i < seedPop; i++) {
    float x = random(-r,r);
    float y = random(-1,1)*sqrt(r*r-x*x);
    Node seed = new Node(x + width/2, y + height/2);
    seeds.add(seed);
  }
  vein = new Vein(mouseX, mouseY);
}

class Node {
    PVector loc, prevLoc;
    float thickness;
  int index;

    Node(float x, float y) {
        loc = new PVector(x, y);
    index = 0;
    }

    void update() {
    }

    void display() {
    noStroke();
    fill(20, 20);
    ellipse(loc.x, loc.y, 20, 20);
    fill(20);
    ellipse(loc.x, loc.y, 4, 4);

    //text(index, loc.x, loc.y);
    }
}

class Vein {
  ArrayList<Node> nodes = new ArrayList<Node>();
  float startX, startY, counter, interval, stepSize, killDist;

  Vein(float _startX, float _startY) {
    startX = _startX;
    startY = _startY;
    interval = 0.1;
    counter = 0;
    stepSize = 8;
    killDist = stepSize;

    Node firstNode = new Node(startX, startY);
    firstNode.prevLoc = new PVector(startX, startY);
    nodes.add(firstNode);
  }

  void update() {
    // calc seed neighborhood for each node in vein
    for (Node seed : seeds) {
      worldRecord = pow(10, 10);
      for (int i = 0; i < nodes.size(); i++) {
        float distance = PVector.dist(nodes.get(i).loc, seed.loc);
        if (distance < worldRecord) {
          worldRecord = distance;
          seed.index = i;
        }
      }
    }

    // calc average vector to seeds
    for (int i = 0; i < nodes.size(); i++) {
      PVector sum = new PVector();
      for (Node seed : seeds) {
        if (seed.index == i) {
          PVector diff = PVector.sub(seed.loc, nodes.get(nodes.size()-1).loc);
          sum.add(diff);
        }
      }
      sum.normalize();
      sum.mult(stepSize);

      // add new vein node
      if (counter > interval) {
        if (sum.mag() > stepSize/2) {
          //PVector newLoc = nodes.get(i).loc.copy();
          PVector newLoc = new PVector(nodes.get(i).loc.x, nodes.get(i).loc.y, nodes.get(i).loc.z);
          newLoc.add(sum);
          Node newNode = new Node(newLoc.x, newLoc.y);
          //newNode.prevLoc = nodes.get(i).loc.copy();
          newNode.prevLoc = new PVector(nodes.get(i).loc.x, nodes.get(i).loc.y, nodes.get(i).loc.z);
          newNode.thickness = map(seeds.size(), 0, seedPop, 0.5, 8);
          nodes.add(newNode);
          counter = 0;
        }
      }
    }


    // kill seeds which are too close to vein nodes
    for (Node node : vein.nodes) {
      ArrayList<Node> kills = new ArrayList<Node>();
      for (Node seed : seeds) {
        float dist = PVector.sub(seed.loc, node.loc).mag();
        if(dist < killDist) {
          s = seed;
          kills.add(s);
        }
      }
      for(Node k : kills) {
        seeds.remove(k);
      }
      kills.clear();
    }
    counter += 1;
    display();
  }

  void display() {
    /*
    for(int i = 0; i < nodes.size(); i++) {
      text(i, nodes.get(i).loc.x, nodes.get(i).loc.y);
    }

    stroke(100);
    noFill();
    beginShape();
    for(Node node : nodes) {
      vertex(node.loc.x, node.loc.y);
    }
    endShape();
    */
    for(Node node : nodes) {
      /*
      noStroke();
      fill(0);
      ellipse(node.loc.x, node.loc.y, 8, 8);
      */
      stroke(0);
      strokeWeight(node.thickness);
      line(node.prevLoc.x, node.prevLoc.y, node.loc.x, node.loc.y);
    }
  }
}
