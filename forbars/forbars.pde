int k;
//int j = 0;
void setup(){
  size(1000, 1000);
  frameRate(10);
  smooth();
}

void draw(){
  background(255);
  fill(0);
  for (int i = 100; i < width-100; i+=40){
    for(int j = 100; j < height-100; j+=30){
      k = int(random(10, 50));
      rect(j, i, k, 20);
    }
  }
  //saveFrame("output/###.png");
}
