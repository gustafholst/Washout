

  PVector down = new PVector(-0.002, 0.04);
  PVector right = new PVector(0.015, -0.001);
  PVector left = new PVector(-0.015, 0);
  PVector up = new PVector(0.002, -0.04);

class Cell {
  
  int size;
  
  PVector loc;
  PVector vel;
  PVector acc;
  
  boolean[] isAttracted = {false, false, false};
  boolean isFlushed;
  int fade;
  int lifetime;
  
  Cell(float x, float y, int s) {
    size = s;
    this.loc = new PVector(x,y); 
    this.vel = new PVector(0,0);
    this.acc = new PVector(0,0);
    fade = 255;
    lifetime = 16 * 60;   
    isFlushed = false;
  }
  
  Cell(Cell cellCopy) {
   size = cellCopy.size;
   this.loc = new PVector(cellCopy.loc.x, cellCopy.loc.y);  
   this.vel = new PVector(0,0);
   this. acc = new PVector(0,0);
   fade = 255;
   lifetime = 16 * 60;   
   isFlushed = false;
  }
  
  void display() {
    
    fill(255, fade);
    stroke(1,fade);
    ellipse(loc.x,loc.y,size,size); 
  }
  
  void flow() {
    if (!isFlushed) {
      if (loc.x < 130 && loc.y < 270)
        applyForce(down);
      if (loc.x < 130 && loc.y > 270)
        applyForce(right);
      if (loc.x > 440 && loc.y < 240)
        applyForce(left);
      if (loc.x > 440 && loc.y > 240)
        applyForce(up); 
        
      if (loc.x > 130 && loc.x < 440 && loc.y < 255)
        applyForce(left);
      if (loc.x > 130 && loc.x < 440 && loc.y > 255)
        applyForce(right); 
   }
  }
  void move() { 
   loc.add(PVector.random2D().mult(0.5));
  }
  
  void update() {
    this.vel.add(acc);
    this.loc.add(vel);
    this.acc.mult(0); 
    
    lifetime--;
    if (lifetime < 0)
      fade -= 1;
  }
  
  void applyForce(PVector force) {
    this.vel.mult(random(0.982,0.99)); 
    this.acc.add(force);
  }
  
  Cell split () {
      return new Cell(loc.x, loc.y, size);
  }
  
  void checkContainer() {

    if (loc.y < 138) 
      applyForce(down);
    if (loc.x < 30)
      applyForce(right);
    if (loc.x > 580) 
      applyForce(left);
    if (loc.y > 362) 
      if (loc.x < 488 || loc.x > 505)
        applyForce(up);
  }
  
  boolean isDead() {
     return (loc.x > width || loc.x < 0 || loc.y < 0 || loc.y > height - 10 || fade == 0);
  }
  
}