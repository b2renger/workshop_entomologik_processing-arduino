Node[] nodes = new Node[0];
Spring[] springs = new Spring[0];
int idNode=0;
float nodeDiameter = 15;
Node selectedNode = null;

int nbranch = 0;

float ratio = 1.61803398875;

void setup() {
  size(1200, 600,P2D);
  background(0);
  smooth();
  noStroke();
  
  strokeWeight(1);
  
  float rad = nodeDiameter/2;
  Node newNode = new Node(width/2, height-rad);
  newNode.setBoundary(rad, rad, width-rad, height-rad);
  newNode.setRadius(50);
  newNode.setStrength(5);
  nodes = (Node[]) append(nodes, newNode);
  
  newNode = new Node(width/2, height-100);
  newNode.setBoundary(rad, rad, width-rad, height-rad);
  newNode.setRadius(50);
  newNode.setStrength(5);
  nodes = (Node[]) append(nodes, newNode);
  idNode +=1;
  
  Spring newSpring2 = new Spring(nodes[0], nodes[1]);
        newSpring2.setLength(random(25, 75));
        newSpring2.setStiffness(1);
        springs = (Spring[]) append(springs, newSpring2);
  
  idNode+=1;
}

void draw() {

    background(0);
  // Springs
  noFill();
  stroke(255);
  for (int i = 0; i < springs.length; i++) {
    springs[i].update();// apply spring forces
    //draw springs
    springs[i].drawMe();
    //strokeWeight(nodeDiameter/4);
    //curve(springs[i].fromNode.x+150, springs[i].fromNode.y+150,springs[i].fromNode.x, springs[i].fromNode.y, springs[i].toNode.x, springs[i].toNode.y, springs[i].toNode.x-150, springs[i].toNode.y-150);
    //line(springs[i].fromNode.x, springs[i].fromNode.y, springs[i].toNode.x, springs[i].toNode.y);
  } 
  // Nodes
  noStroke();
  for (int i = 2; i < nodes.length; i++) {
    nodes[i].attract(nodes);// let all nodes repel each other
    nodes[i].update();// apply velocity vector and update position
    // draw nodes
    fill(255);
    ellipse(nodes[i].x, nodes[i].y, nodeDiameter-10, nodeDiameter-10);
     fill(255, 120);
    ellipse(nodes[i].x, nodes[i].y, nodeDiameter+5, nodeDiameter+5);
    // fill(255, 180);
    //ellipse(nodes[i].x, nodes[i].y, nodeDiameter-8-i, nodeDiameter-8-i);
  }
  fill(255);
   ellipse(nodes[1].x, nodes[1].y, nodeDiameter-5, nodeDiameter-5); 
  fill(255 ,150);
 
  ellipse(nodes[1].x, nodes[1].y, nodeDiameter+15, nodeDiameter+15);

  if (selectedNode != null) {
    selectedNode.x = mouseX;
    selectedNode.y = mouseY;
  }
  
      Node inverseGravityNode = new Node(width/2, height);
    inverseGravityNode.setRadius(500);
    inverseGravityNode.setStrength(-2);
    inverseGravityNode.attract(nodes);
}

void mousePressed() {
  // Ignore anything greater than this distance
  float maxDist = 20;
  for (int i = 0; i < nodes.length; i++) {
    Node checkNode = nodes[i];
    float d = dist(mouseX, mouseY, checkNode.x, checkNode.y);
    if (d < maxDist) {
      selectedNode = checkNode;
      maxDist = d;
    }
  }
}

void mouseReleased() {
  
  if (idNode == 0){
    
    
    
  }


  float maxDist = 20;
  for (int i = 0; i < nodes.length; i++) {
    Node checkNode = nodes[i];
    float d = dist(mouseX, mouseY, checkNode.x, checkNode.y);
    if (d < maxDist) {
      maxDist = d;
      selectedNode = checkNode;

      float rad = nodeDiameter/2;

      // create node
      Node newNode = new Node(mouseX+random(-10, 10), mouseY+random(0, -50));
      newNode.setBoundary(rad, rad, width-rad, height-rad*4);
      newNode.setRadius(150);
      newNode.setStrength(-1);
      nodes = (Node[]) append(nodes, newNode);
      idNode+=1; // incr node id
      // create another one
      Node newNode2 = new Node(mouseX+random(-10, 10), mouseY/2+random(-0, -50));
      newNode2.setBoundary(rad, rad, width-rad, height-rad-4);
      newNode2.setRadius(150);
      newNode2.setStrength(-0.5);
      nodes = (Node[]) append(nodes, newNode2);
      idNode+=1;// incr node id
      // link them to previous node
      if (idNode>=2) {
        Spring newSpring2 = new Spring(selectedNode, nodes[idNode-2]);
        newSpring2.setLength(random(25, 75));
        newSpring2.setStiffness(1);
        springs = (Spring[]) append(springs, newSpring2);
        println(idNode);
        Spring newSpring3 = new Spring(selectedNode, nodes[idNode-1]);
        newSpring3.setLength(random(25, 75));
        newSpring3.setStiffness(1);
        springs = (Spring[]) append(springs, newSpring3);
      }
    }
    
    
    
    if (selectedNode != null) {
      selectedNode = null;
    }
  }
}

