int numDots = 45;

String[] trailLengths = {"Short", "Medium", "Long", "Huge"};

// Create Dots
Dot[] dots = new Dot[numDots];

// Create Squares
Square[][] squares = new Square[20][20];

// Grid positions
PVector[] gridPositions = new PVector[400];

void setup(){
  size(900, 900);
  //background(20);
  frameRate(24);
  smooth();
  
  // Initialize Squares and store grid positions
  int squareX = -450;
  int squareY = -450;
  int gridPosCounter = 0;

  for (int i = 0; i < 20; i++) {
    squareX = -450;
    for (int j = 0; j < 20; j++) {
      squares[i][j] = new Square(squareX, squareY);
      PVector gridPosition = new PVector(squareX, squareY);
      // System.out.println(gridPosition);
      gridPositions[gridPosCounter] = gridPosition;
      gridPosCounter++;
      squareX += 45;
    }
    squareY += 45;
  }

  // Initialize Dots
  for (int i = 0; i < numDots; i++) {
    PVector randomPos = gridPositions[(int)random(gridPositions.length)];
    dots[i] = new Dot(randomPos.x, randomPos.y);
  }

}

void draw() {
  translate(width/2, height/2);
  
  // Draw grid
  for (int i = 0; i < squares[0].length; i++) {
    for (int j = 0; j < squares[0].length; j++) {
      squares[i][j].update();
    }
  }

  for (int i = 0; i < numDots; i++) {
    dots[i].updatePosition();  
    dots[i].show();
  }
  

  // saveFrame("output/####.png");
  if (keyPressed && (key == 's' || key == 'S')) {
    saveFrame("select/####.tiff");
    saveFrame("select/####.png");
  }
}

class Square {
  float sx, sy;
  float size = 45;
  float inc = random(1, 2);

  float HUE = 30;
  float SATURATION_MAX = 50.0;
  float SATURATION_MIN = 3.0;
  float SATURATION = random(SATURATION_MIN, SATURATION_MAX);
  float BRIGHTNESS = 80.0;
  
  Square (float x, float y) {
    this.sx = x;
    this.sy = y;
  }
  
  void update () {
    if (SATURATION >= SATURATION_MAX || SATURATION <= SATURATION_MIN) {
      inc = -inc;
    }
    
    colorMode(HSB, 360, 100, 100);
    fill(HUE, SATURATION, BRIGHTNESS);
    noStroke();
    rect(sx, sy, size, size);
    SATURATION += inc;
  }
}

class Dot {

  float x, y;
  PVector position;
  ArrayList<PVector> history = new ArrayList<PVector>();

  int stepThreshold;
  String trailLength = trailLengths[(int)random(trailLengths.length)];

  int stepCount;
  float randomVar = random(1);
  float dotRadius = 5.0;
  
  Dot (float x, float y) {
    this.x = x;
    this.y = y;

    switch (trailLength) {
      case "Short" :
        stepThreshold = 180;
      break;	

      case "Medium" :
        stepThreshold = 360;
      break;	

      case "Long" :
        stepThreshold = 450;
      break;	

      case "Huge" :
        stepThreshold = 540;
      break;	
    }
  }
  
  
  void updatePosition() {

    if (stepCount == stepThreshold) {
      randomVar = random(1);
      stepCount = 0;
    }

    if (randomVar > 0.75) {
      x +=1;
    } else if (randomVar >= 0.5) {
      y -= 1;
    } else if (randomVar >= 0.25) {
      y += 1;
    } else {
      x -= 1;
    }
    
    position = new PVector(x, y);
    history.add(position);

    if (history.size() > stepThreshold * 1.5) {
      history.remove(0);
    }
    stepCount++;
  }

  void show() {
    fill(0);
    ellipse(x, y, dotRadius, dotRadius);

    for (PVector pos : history) {
      ellipse(pos.x, pos.y, 1, 1);
    }

    // stepCount++;
  }
}