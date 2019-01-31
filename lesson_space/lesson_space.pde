//Apologies for the lack of comments/inconsistent code. Hopefully will have time to work on a fix!

//Which generator is currently active?
//0 - random
//1 - primitives
//2 - primitives lite
//3 - chunks
//4 - human
int generator = 0;

//We use this to record how many levels of each type we generated
int[] generatorStats;

//The dimensions of our generated levels, in tiles
int levelWidth = 40;
int levelHeight = 10;

//In pixels, for drawing
int tilesize = 30;

//The last level we generated
int[][] theLevel;

void GenerateLevel(){
   if(generator == 0)
     GenerateRandomLevel();
   if(generator == 1)
     GeneratePrimitiveLevel(35);
   if(generator == 2)
     GeneratePrimitiveLevel(20);
   if(generator == 3)
     GenerateChunkedLevel();
   if(generator == 4)
     GenerateHumanLevel();
     
   if(generatorStats == null)
     generatorStats = new int[5];
   generatorStats[generator]++;
}

void GenerateRandomLevel(){
    int[][] level = new int[levelWidth][levelHeight];
    
    //For every tile in the map...
    for(int i=0; i<levelWidth; i++){
     for(int j=0; j<levelHeight; j++){
       //Randomly place one of the tile types here
       level[i][j] = int(random(3));
     }
    }
    
    //Add a random start tile
    level[0][int(random(levelHeight))] = -1;
    //Add a random exit tile
    level[levelWidth-1][int(random(levelHeight))] = -2;
    
    theLevel = level;
}

void GeneratePrimitiveLevel(int numberOfShapes){
   int[][] level = new int[levelWidth][levelHeight];
   
   int maxPrimitiveSize = 5;
   
   //We'll use these to place the primitives later
   int x = 0; int y = 0; int t = 0;
   
   //Place a number of shapes up to the limit
   for(int p=0; p<numberOfShapes; p++){
     switch(int(random(3))){
       //Place a horizontal line
       case 0: 
         x = int(random(levelWidth));
         y = int(random(levelHeight));
         //Note that primitives are always solid, we never place empty space
         t = 1+int(random(2));
         for(int l=0; l<int(random(maxPrimitiveSize)); l++){
           level[(x+l)%levelWidth][y] = t; 
         }
       //Place a vertical line
       case 1: 
         x = int(random(levelWidth));
         y = int(random(levelHeight));
         //Note that primitives are always solid, we never place empty space
         t = 1+int(random(2));
         for(int l=0; l<int(random(maxPrimitiveSize)); l++){
           level[x][(y+l)%levelHeight] = t; 
         }
       //Draw a box
       case 2:
         x = int(random(levelWidth));
         y = int(random(levelHeight));
         int w = int(random(maxPrimitiveSize));
         int h = int(random(maxPrimitiveSize));
         //Note that primitives are always solid, we never place empty space
         t = 1+int(random(2));
         for(int i=0; i<w; i++){
           for(int j=0; j<h; j++){
             level[(x+i)%levelWidth][(y+j)%levelHeight] = t; 
           }
         }
     }
   }
   
   //Add a start and an exit, but this time intelligently place them on top of something (if possible)
   boolean hasStart = false;
   for(int i=0; i<levelHeight-1; i++){
     if(!hasStart && level[0][i+1] > 0 && level[0][i] == 0){
        level[0][i] = -1; 
        hasStart = true;
     }
   }
   if(!hasStart)
     level[0][int(random(levelHeight))] = -1;
     
   boolean hasExit = false;
   for(int i=0; i<levelHeight-1; i++){
     if(!hasExit && level[levelWidth-1][i+1] > 0 && level[levelWidth-1][i] == 0){
        level[levelWidth-1][i] = -2; 
        hasExit = true;
     }
   }
   if(!hasExit)
     level[levelWidth-1][int(random(levelHeight))] = -2;
   
   theLevel = level;
}

void GenerateChunkedLevel(){
   int[][] level = new int[levelWidth][levelHeight];
   int chunkWidth = 5;
   
   for(int c=0; c<levelWidth/chunkWidth; c++){
     int[][] chunk = GetChunk();  
     if(c == 0)
       chunk = GetStartChunk();
     if(c == (levelWidth/chunkWidth)-1)
       chunk = GetEndChunk();
     //Go through the chunk we've found
     for(int i=0; i<chunk.length; i++){
       for(int j=0; j<chunk[0].length; j++){
         //Copy the data from the chunk into our level
         level[(c*chunkWidth)+i][j] = chunk[i][j];
       }
     }
   }
   theLevel = level;
}

void GenerateHumanLevel(){
   theLevel = GetHumanLevel(); 
}

PImage tile_dirt;
PImage tile_grass;
PImage tile_box;

void setup(){
   tile_dirt = loadImage("tile_dirt.png");
   tile_grass= loadImage("tile_grass.png");
   tile_box = loadImage("tile_box.png");
  
  //Comment this line out if you like a border around each tile.
  noStroke();
  
  //Note: Processing only lets us use exact numbers, so this assumes 40 tiles wide + tile size of 30 px
   size(1220, 550);
   GenerateLevel(); 
}

color GetColor(int code){
   switch(code){
     case 0: return color(228,247,255);
     case 1: return color(102,51,0);
     case 2: return color(255,255,51);
     case -1: return color(255,0,0);
     case -2: return color(102,0,204);
     default: return color(0);
   }
}

void draw(){
  background(255, 255, 255);
  
  textAlign(LEFT, CENTER);
  int tx = 10;
  int tr = 56;
  
  for(int i=0; i<levelWidth; i++){
     for(int j=0; j<levelHeight; j++){
         //This selects a colour based on the tile and draws a rectangle to make the map.
         fill(GetColor(theLevel[i][j]));
         rect(tx+i*tilesize, j*tilesize+tr, tilesize, tilesize);
         
         //This draws nice tile sprites (thanks to Kenney!) on top of the boring coloured squares.
         if(theLevel[i][j] == 1){
          if((j == 0 || theLevel[i][j-1] == 0)){
             image(tile_grass, tx+i*tilesize, j*tilesize+tr, tilesize, tilesize);
          }
           else{
             image(tile_dirt, tx+i*tilesize, j*tilesize+tr, tilesize, tilesize);
          }
         }
         else if(theLevel[i][j] == 2){
            image(tile_box, tx+i*tilesize, j*tilesize+tr, tilesize, tilesize);
         }
     }
  }
  
  //These are horrible alignment variables I used, they make the code ugly, don't worry about following these hacks!
  int legend_x = 10;
  int legend_y = 25;
  
  fill(color(0));
  textSize(20);
  text("Level Tile Key", legend_x, legend_y);
  legend_x += 160;
  
  textAlign(LEFT, CENTER);
  textSize(16);
  
  fill(GetColor(0));
  rect(legend_x, legend_y-5, tilesize/2, tilesize/2);
  legend_x += tilesize/2 + 10;
  fill(color(0));
  text("Empty Space", legend_x, legend_y);
  legend_x += 130;
  
  fill(GetColor(1));
  rect(legend_x, legend_y-5, tilesize/2, tilesize/2);
  legend_x += tilesize/2 + 10;
  fill(color(0));
  text("Solid Block", legend_x, legend_y);
  legend_x += 110;
  
  fill(GetColor(2));
  rect(legend_x, legend_y-5, tilesize/2, tilesize/2);
  legend_x += tilesize/2 + 10;
  fill(color(0));
  text("Powerup Block", legend_x, legend_y);
  legend_x += 140;
  
  fill(GetColor(-1));
  rect(legend_x, legend_y-5, tilesize/2, tilesize/2);
  legend_x += tilesize/2 + 10;
  fill(color(0));
  text("Level Start", legend_x, legend_y);
  legend_x += 110;
  
  fill(GetColor(-2));
  rect(legend_x, legend_y-5, tilesize/2, tilesize/2);
  legend_x += tilesize/2 + 10;
  fill(color(0));
  text("Level Exit", legend_x, legend_y);
  legend_x += 120;
  
  text("Current Generator: "+GetGeneratorName(generator), 10, tr+tilesize*levelHeight+20);
  
  textAlign(RIGHT, CENTER);
  text("Press R to generate a new level", tilesize*levelWidth, tr+tilesize*levelHeight+20);
  
  text("Levels generated with this generator: "+generatorStats[generator], tilesize*levelWidth, tr+tilesize*levelHeight+60);
  text("(Press C to clear this statistic)", tilesize*levelWidth, tr+tilesize*levelHeight+90);
  
  text("More at www.possibilityspace.org", tilesize*levelWidth, tr+tilesize*levelHeight+160);
  
  textAlign(LEFT, CENTER);
  textSize(14);
  text("Press a number key to select a generator:", 10, tr+tilesize*levelHeight+60);
  for(int i=0; i<5; i++){
      text("["+(i+1)+"] - "+GetGeneratorName(i), 10, tr+tilesize*levelHeight+80+(i*20));
  }
  
  noLoop();
}

String GetGeneratorName(int gen){
    switch(gen){
       case 0: return "Random Generator";
       case 1: return "Shape-Based Generator [Large]";
       case 2: return "Shape-Based Generator [Small]";
       case 3: return "Chunk-Based Generator";
       case 4: return "Human Level Designs";
    }
    return "<ERROR>";
}

void keyPressed() {
  //E - Perform an Expressive Range Analysis
  if (key == 'r') {
    GenerateLevel();
  }
  if (key == 'c') {
    generatorStats[generator] = 0; 
  }
  if (key == '1') {
    generator = 0;
    GenerateLevel();
  }
  if (key == '2') {
    generator = 1;
    GenerateLevel();
  }
  if (key == '3') {
    generator = 2;
    GenerateLevel();
  }
  if (key == '4') {
    generator = 3;
    GenerateLevel();
  }
  if (key == '5') {
    generator = 4;
    GenerateLevel();
  }
  redraw();
}