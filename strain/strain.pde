float radius = 900/3.5;
float oRadius = 900/2.5; 
int numPoints = 50;
float angle = TWO_PI / (float)numPoints;

int numDots = 100;
int squareFillMax = 200;
int squareFillMin = 100;

boolean hide = true;
int lastHide = 0; // Number of frames since last hide began
int hideDuration = 75; // Minimum number of frames to hide for between reveals (3 seconds)

boolean reveal = false;
int lastReveal = 0; // Number of frames since last reveal began
int revealDuration = 45; // Reveal duration in frames

int coin;

// Create Dots
Dot[] dots = new Dot[numDots];

// Create Squares
Square[][] squares = new Square[20][20];

void setup(){
  size(900, 900);
  //background(20);
  frameRate(30);
  smooth();
  
  randomSeed(12);
  
  // Initialize Dots
  for (int i = 0; i < numDots; i++) {
    dots[i] = new Dot(random(-width/2, width/2), random(-height/2, height/2));
  }
  
  // Initialize Squares
  int squareX = -450;
  int squareY = -450;
  for (int i = 0; i < 20; i++) {
    squareX = -450;
    for (int j = 0; j < 20; j++) {
      squares[i][j] = new Square(squareX, squareY);
      squareX += 45;
    }
    squareY += 45;
  }
}

void draw(){
  translate(width/2, height/2);
  
  coin = (int) random(2);
  
  if (hide) {
    if (lastHide <= hideDuration) {
      hide();
      lastHide++;
    } else if (coin == 1) {
      hide();
    } else {
      reveal = true;
    }
  }
  
  if (reveal) {
    if (lastReveal <= revealDuration) {
      reveal();
      lastReveal++;
    } else if (coin == 1) {
      reveal();
    } else {
      hide = true;
    }
  }

  //saveFrame("output_phase1/####.png");
  if (keyPressed && (key == 's' || key == 'S')) {
    saveFrame("select/####.tiff");
    saveFrame("select/####.png");
  }
}

void hide() {
  reveal = false;
  lastReveal = 0;
  revealDuration = (int) random(15, 75);
  
  fill(20);
  noStroke();
  rect(-width/2, -height/2, width, height); // background when in "hidden" state
  drawCurves(255);
}

void reveal(){
  hide = false;
  lastHide = 0;
  hideDuration = (int) random(45, 90);
  
  // Draw grid
  for (int i = 0; i < squares[0].length; i++) {
    for (int j = 0; j < squares[0].length; j++) {
      squares[i][j].update();
    }
  }
  
  noStroke();
  //rect(-width/2, -height/2, width, height); // background when in "hidden" state
  // Draw dots
  for (int i = 0; i < numDots; i++) {
    dots[i].updatePosition();  
  }
  
  drawCurves(0);
}

void drawCurves(int stroke) {
  // control points for bezier curve
  float ctrl1x = random(-5, 5);
  float ctrl1y = random(-5, 5);
  float ctrl2x = random(-5, 5);
  float ctrl2y = random(-5, 5);
  
  float halfNumPoints = 5;
  stroke(stroke);
  for (int i=0; i < numPoints; i++) {
    
    
    noFill();
    beginShape();
    vertex(radius * sin(angle * i ), radius * cos(angle * i));
    bezierVertex(ctrl1x, ctrl1y, ctrl2x, ctrl2y, (float)(radius * sin(angle * (i+halfNumPoints))), (float)(radius * cos(angle * (i+halfNumPoints))));
    endShape();
    
    //int randomI = (int)random(numPoints);
    //line(radius * sin(angle*i), radius * cos(angle*i), oRadius * sin(angle * randomI),oRadius * cos(angle*randomI) );
    
    //point(radius * sin(angle * i), radius * cos(angle * i));
    //point(oRadius * sin(angle * i), oRadius * cos(angle * i));
  }
}


class Square {
  float sx, sy;
  float size = 45;
  int fill;
  int inc = 5;
  
  Square (float x, float y) {
    this.sx = x;
    this.sy = y;
    fill = (int) random(160, 240);
  }
  
  void drawTile() {
    fill(fill);
    noStroke();
    rect(sx, sy, size, size);
  }
  
  void update () {
    if (fill > squareFillMax) {
      inc = -5;
    }
    
    if (fill < squareFillMin) {
      inc = 5;
    }
    
    noStroke();
    fill(fill);
    rect(sx, sy, size, size);
    fill += inc;
  }
}

class Dot {
  
  float x, y;
  float dotRadius = 5.0;
  float speedX = 4.0;
  float speedY = 5.0;
  int directionX = 1;
  int directionY = -1;
  
  float randlimit = 3;
  
  Dot (float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  
  void updatePosition(){
    fill(0);
    ellipse(x, y, dotRadius, dotRadius);
    x += random(-randlimit,randlimit);
    if ((x > width/2 - dotRadius) || (x < (-width/2) + dotRadius)) {
      directionX = -directionX;
    }
    
    y += random(-randlimit,randlimit);
    if ((y > height/2 - dotRadius) || (y < (-height/2) + dotRadius)) {
      directionY = -directionY;
    }
  }
}
