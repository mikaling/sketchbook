float t = 0;

void setup() {
  size(800, 800);
  background(20);
  //frameRate(30);
  colorMode(HSB);
}

void draw() {
  //background(20);
  
  translate(width/2, height/2);
  noStroke();
  fill(0, 70);
  rect(-width/2, -height/2, width, height);
  
  stroke(255);
  strokeWeight(4);
  for (int i = 0; i < 120; i++){
    stroke(t % 360, 180, 200);
    point(x1(t + i), y1(t + i));  
  }
  t+=0.95;
  
  //saveFrame("out/####.png");
}

float x1(float t){
  return sin(t/15)*200 + sin(t /30) *60;
}

float y1(float t){
  return cos(t/10)*200;
}
