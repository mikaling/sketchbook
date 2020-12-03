float radius = 900/3.5;
float oRadius = 900/2.5; 
int numPoints = 50;
float angle = TWO_PI / (float)numPoints;

void setup(){
  size(900, 900);
  background(20);
  frameRate(30);
  smooth();
}

void draw(){
    translate(width/2, height/2);

  //fill(255);
  background(20);
  stroke(255);
  
  // control points for bezier curve
  float ctrl1x = random(-5, 5);
  float ctrl1y = random(-5, 5);
  float ctrl2x = random(-5, 5);
  float ctrl2y = random(-5, 5);
  
  float halfNumPoints = 5;
  for(int i=0; i < numPoints; i++){
    //point(radius * sin(angle * i), radius * cos(angle * i));
    //point(oRadius * sin(angle * i), oRadius * cos(angle * i));
    int randomI = (int)random(numPoints);
    noFill();
    beginShape();
    vertex(radius * sin(angle * i ), radius * cos(angle * i));
    bezierVertex(ctrl1x, ctrl1y, ctrl2x, ctrl2y, (float)(radius * sin(angle * (i+halfNumPoints))), (float)(radius * cos(angle * (i+halfNumPoints))));
    endShape();

    //line(radius * sin(angle*i), radius * cos(angle*i), oRadius * sin(angle * randomI),oRadius * cos(angle*randomI) );
  }

  //saveFrame("output_phase1/####.png");
  if (keyPressed && (key == 's' || key == 'S')) {
    saveFrame("select/####.tiff");
    saveFrame("select/####.png");
  }
}
