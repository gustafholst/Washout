
class Arrow {
  
  float x,y;
  int start,end;
  int fade;
  float speed;
  int origin;
  
  Arrow(int x, int start, int origin, int end) {
    this.x = x;
    this.y = start;
    this.start = start;
    this.end = end;
    this.origin = origin;
    fade = 255;
    speed = 1;
  }
  
  void display(char c) {
    
    noStroke();
    if (c == 'g')
      fill(0,255,0,fade);
    if (c == 'r')
      fill(255,0,0,fade);
     
    //arrow
    pushMatrix();
    translate(x,y);
    rect(0,0,6,20);
    triangle(-5,20,3,28,11,20);
    popMatrix();
  }
  
  void move(float s) {
    y += s;
    if (y > end-30)
      fade -= 20;
    if (y > end) {
      y = origin;
      fade = 255;
    }
  }
}