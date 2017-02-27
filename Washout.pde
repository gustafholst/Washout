/*
Washout v1.0
by Gustaf Holst 2017
*/

ArrayList<Cell> cells = new ArrayList<Cell>();

PImage container;

Attractor att0,att1,att2;

Arrow inArrow1;
Arrow outArrow1;
Arrow inArrow2;
Arrow outArrow2;

int flow;

HScrollbar bar1,bar2;
boolean scrollbar = false;

int attractionRadius;
int growthSpeed;
int splitIndex;

void setup() {
  size(640,515);
  
  container = loadImage("container.png");
  container.loadPixels();

  att0 = new Attractor(497,370, 0, 10);
  att1 = new Attractor(497,425, 1, 10);
  att2 = new Attractor(497,529, 2, 10);
  
  inArrow1 = new Arrow(85,-30,-30,120);
  inArrow2 = new Arrow(85, 40,-30,120);
  outArrow1 = new Arrow(494,350,350,500);
  outArrow2 = new Arrow(494,420,350,500);
  
  bar1 = new HScrollbar(40,450,100,20,2);
  
  splitIndex = 0;
}

void draw() {
  background(container);
   
  displayScrollbar();
  
  flow = (int)map(bar1.getPos(),0,1,0,100); 
   
  growthSpeed = (int)map(bar1.getPos(),0.4,0.6, 90, 30);
  int attractionRadius = (int)map(bar1.getPos(),0,1,10,110);
  
  if (flow > 60) {
    attractionRadius = (int)map(bar1.getPos(),0.6,1.0,80,200); 
    growthSpeed = (int)map(bar1.getPos(),0.6,1.0, 30, 10);
  }
  
  if (flow < 40) {
    growthSpeed = (int)map(bar1.getPos(),0.0,0.4, 2000,17*60);   
  }

  if (cells.size() != 0) 
     println(splitIndex);
      
  textSize(20);
  fill(0);
  text("antal celler: " + cells.size(), width/2, 50);
  textSize(14);
  text("flöde: " + flow + "%", 40, 430);
  textSize(10);
  text("Klicka i tanken för att lägga till celler manuellt",40,500);
   
  float arrowSpeed = map(bar1.getPos(),0,1,0,4);
  inArrow1.move(arrowSpeed);
  inArrow1.display('g');
  inArrow2.move(arrowSpeed);
  inArrow2.display('g');
  outArrow1.move(arrowSpeed);
  outArrow1.display('r');
  outArrow2.move(arrowSpeed);
  outArrow2.display('r');
    
  for (int i = cells.size()-1; i >= 0; i--) {
    Cell c = cells.get(i);
    
    c.update();
    c.move(); 
    if (flow > 20)
      c.flow();
    else
      c.vel.mult(0.99);
    c.checkContainer();
    c.display();
    
    
    if (dist(c.loc.x,c.loc.y,att0.loc.x,att0.loc.y) < attractionRadius && !c.isFlushed) {
       c.isFlushed = true;
       c.isAttracted[0] = true;
    }
    
    if (c.isDead())
      cells.remove(i);
  
    if (c.isAttracted[0]) {
      att0.attract(c); 
    }
    if (c.isAttracted[1]) {
      att1.attract(c); 
      c.fade -= 0.1;
    }
    if (c.isAttracted[2]) {
      att2.attract(c);      
    }

  }

  if (splitIndex >= cells.size())
        splitIndex = 0;
        
  if (growthSpeed > 0) {
    if (frameCount % growthSpeed == 0) {
      boolean cellAdded = false;
      while (!cellAdded && cells.size() != 0 && splitIndex < cells.size()) {        
        Cell c = cells.get(splitIndex);
        if (c.lifetime > 0 && !c.isFlushed) {
          cells.add(c.split());
          cellAdded = true;
        }
        splitIndex++;   
      }
    }
  }
}

void mousePressed() {
    addCell();
}

void addCell() {
  if (mouseX > 30 && mouseX < 580 && mouseY < 372 && mouseY > 138) {
    cells.add(new Cell(mouseX, mouseY,10));
  }
 
}
  
void displayScrollbar() {
  bar1.update();
  bar1.draw();
}