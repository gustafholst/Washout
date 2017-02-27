class Attractor {
  
  float mass;
  PVector loc;
  int attNum;
  int attRadius;
  
  Attractor(float x, float y , int num, int aR) {
    loc = new PVector(x,y);
    attNum = num;
    mass = 10 + (5*num);
    attRadius = aR;
  }
  
  void display() {
    fill(255,0,0);
    ellipse(loc.x, loc.y, mass, mass);
  }
  
  void attract(Cell c) {
    PVector f = PVector.sub(loc, c.loc);
    float distance = f.mag();
    f.normalize();
    float strength = constrain(mass*20/(distance*distance),0,2);
    f.mult(strength);
    if (distance > attRadius) {   
      c.applyForce(f);
    }
    
    else {
      if (attNum == 0)
        c.vel.mult(0.04);
      else {
        c.applyForce(f);
      }
        
      if (attNum < c.isAttracted.length-1) {
        c.isAttracted[attNum] = false;
        c.isAttracted[attNum + 1] = true;
      }
    }
  }
}