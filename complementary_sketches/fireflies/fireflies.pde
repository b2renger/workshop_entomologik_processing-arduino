


ArrayList <Firefly> fireflies = new ArrayList();

boolean debug = false;

void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);

  PImage img = loadImage("texture.png");
  for (int i = 0; i < 250; i++) {
    fireflies.add( new Firefly(i, random(width), random(height), img));
  }
}

void draw() {
  // cheap motion blur
  noStroke();
  fill(0, 15);
  rect(0, 0, width, height);

  // update our fireflies
  for (Firefly f : fireflies) {
    f.update();
  }
}

// disturb the clocks
void mouseDragged() {
  for (Firefly f : fireflies) {
    float d = dist(f.position.x, f.position.y, mouseX, mouseY);
    if (d < 200 ) {
      f.life = random(0, 1);
    }
  }
}

void keyPressed(){
 debug = !debug; 
}



class Firefly {

  float life; // this is our clock when it equals 0 we flash

  // those are rendering parameters
  float s; // this is the size of the firefly it will change when flashed
  float alpha = 5; // transparency
  PImage img;

  int id;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float noiseF = random(5200);

  Firefly(int id, float xpos, float ypos, PImage img) {

    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    position = new PVector(xpos, ypos);

    s = 15;
    life = random(0, 1); // life is given as a random value at the beginning

    this.img = img;
    this.id = id;
  }


  void update() {


    // update rendering parameters
    s = 15; // not flashing
    alpha = alpha - alpha*0.05; // alpha slowly decays

    // update the clock
    life += 0.0055;

    // Flash !
    if (life > 1 ) {

      s = 75; // bigger size
      alpha = 100; // a full opacity

      life = 0; // reset the life to start a new cycle

      // since we flashed, this will excite the neighboring fireflies !
      for (int i = 0; i < fireflies.size(); i ++) {
        Firefly f = fireflies.get(i);
        if (i != id) { // if it's not ourself
          float d = dist(f.position.x, f.position.y, position.x, position.y);
          if (d < 100 ) { // and if it's close enough
            // we nudge the clock a bit forward
            f.life += f.life*0.25; // 0.25 is a magic number
            // if you get a bigger number fireflies will sync faster
            // if you get a lower number it will take more time
          }
        }
      }
    }

    // Move our firefly with a classic acceleration => velocity => position algorithm

    float angle = noise(noiseF, 35, 52)*TWO_PI*2;
    noiseF += 0.025;
    float xAcc = 1*cos(angle);
    float yAcc = 1*sin(angle);

    acceleration.x += xAcc;
    acceleration.y += yAcc;

    velocity.add(acceleration);
    velocity.limit(1.5);
    position.add(velocity);
    acceleration.mult(0);

    borders();

    render();
  }



  void render() {
    imageMode(CENTER);
    tint(44, 100, 100, alpha+10);
    image(img, position.x, position.y, s, s);

    if (debug == true) {
      pushStyle();
      pushMatrix();
      stroke(255);
      noFill();
      translate(position.x, position.y);
      ellipse(0, 0, 25, 25);
      rotate(life*TWO_PI);
      line(0, 0, 0, -12.5);

      popMatrix();
      popStyle();
    }
  }

  void borders() {
    if (position.x < -s) position.x = width+s;
    if (position.y < -s) position.y = height+s;
    if (position.x > width+s) position.x = -s;
    if (position.y > height+s) position.y = -s;
  }
}