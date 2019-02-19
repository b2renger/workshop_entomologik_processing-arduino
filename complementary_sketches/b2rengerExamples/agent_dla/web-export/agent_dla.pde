ArrayList<Node>  nodes ; // un tableau pour stocker les position en 3D
int nodeSize = 10;
float nrow;
float ncol;


void setup() {
  size(800, 600);
  background(0);
  // initialisation de la position de notre camera
  rectMode(CENTER);
  nodes = new ArrayList<Node>();
  nodes.add(new Node(width/2, height/2, nodeSize));

  ncol = int(width/nodeSize);
  nrow = int(height/nodeSize);
}

void draw() {
  background(0);

  float nmax = (sqrt(nodes.size() + 1) + 1) * 1 ;
  float nmin = nmax * 0.1618; // golden ratio

  float newX =  +int(random(nmin, nmax)) * nodeSize;
  float newY =  +int(random(nmin, nmax)) * nodeSize;


  if (random(1) < 0.5) {
    newX *= -1;
  }
  if (random(1) < 0.5) {
    newY *= -1;
  }
  newX += width/2;
  newY +=height/2;

  fill(255, 0, 0);
  rect(newX, newY, nodeSize, nodeSize);


  boolean found = false;
  for (int i = nodes.size () - 1; i >= 0; i--) {
    Node n = nodes.get(i);
    float d = dist(newX, newY, n.xpos, n.ypos);
    if (d == nodeSize) {
      found = true;
      break;
    }
  }

  if (found) {
    // on vérifie
    boolean already = false;
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n.xpos == newX && n.ypos == newY) {
        already = true;
      }
    }
    if (!already) {
      nodes.add(new Node(newX, newY, nodeSize));
    }
  }

  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.draw();
  }
}




class Node { 
  float xpos;
  float ypos;
  float rad;

  Node(float x, float y, int rad) {
    xpos = x;
    ypos = y;
    this.rad = rad;
  }

  void draw () {
    pushMatrix();
    //texture(this.texture);// on applique notre texture
    stroke(0);
    fill(255, 180, 180);
    translate(this.xpos, this.ypos);
    ellipse(0, 0, rad, rad);
    popMatrix();
  }
}


