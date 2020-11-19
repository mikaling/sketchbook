import java.util.Arrays;

PFont font;
StringBuilder s = new StringBuilder ("origamikink");
char[] letters = {'A', 'K', 'I', 'M', 'K', 'I', 'N', 'G', 'O', 'R', 'I'};
boolean[] used = new boolean[11];   //Boolean array of flags for letters[]. All initialized to false

void setup(){
  frameRate(12);                    //Set framerate to 12fps
  size(1000, 1000);
  font = createFont("OCR A Extended", 86);
  textFont(font);
  fill(255);
  //String[] fontList = PFont.list();
  //printArray(fontList);
}

void draw(){
 background(0);
 for(int i = 0; i < 11; i++){
   int j = int(random(11));   //Generate a random number j from 0 to 10
   while(true){
     if(used[j] == false){          //Check if letter corresponding to j hasn't been used
       s.setCharAt(i, letters[j]);  //Set character in s to the unused letter
       used[j] = true;         //Flag letter as used
       break;
     } else {
       j = int(random(11));         //Generate a different random number
     }
   }
 }
 
 
 
 text(s.toString(), 220, 500);      //display text
 Arrays.fill(used, false);          //set all used values to false to create a new word 
 saveFrame("output/anagram_####.png");  //Save an image for every frame to "output" folder
 
 if(s.toString().equals("AKIMKINGORI")){
   noLoop();
 }
}
