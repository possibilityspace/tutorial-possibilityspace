int[][] GetChunk(){
    int[][][] chunks = new int[][][]{
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,2,0,0,1,1},
        {0,0,2,0,0,2,0,0,1,1},
        {0,0,0,0,0,2,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1}},
        
       {{0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,0,1}},
               
       {{0,0,0,0,0,0,1,1,1,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,1,1,1,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,1,1,1,1}},
        
       {{0,0,0,2,0,0,1,1,1,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,2,0,0,1,1,1,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,2,0,0,1,1,1,1}},
        
       {{0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,1},
        {0,0,0,0,0,0,0,0,1,1}},
    };
    return chunks[int(random(chunks.length))];
}

int[][] GetStartChunk(){
    int[][][] chunks = new int[][][]{
       {{0,0,0,0,0,0,0,-1,1,1},
        {0,0,0,0,0,2,0,0,1,1},
        {0,0,2,0,0,2,0,0,1,1},
        {0,0,0,0,0,2,0,0,1,1},
        {0,0,0,0,0,0,0,0,1,1}},
        
       {{0,0,0,0,-1,1,1,1,1,1},
        {0,0,0,0,0,1,1,1,1,1},
        {0,0,0,0,0,0,1,1,1,1},
        {0,0,0,0,0,0,0,1,1,1},
        {0,0,0,0,0,0,0,0,1,1}},
       
        { {1,1,1,1,0,-1,1,1,1,1},
          {1,1,1,1,0,0,1,1,1,1},
          {1,1,1,1,0,0,1,1,1,1},
          {1,1,1,0,0,0,0,1,1,1},
          {0,0,0,0,0,0,0,0,1,1}},
    };
    return chunks[int(random(chunks.length))];
}

int[][] GetEndChunk(){
    int[][][] chunks = new int[][][]{
       {{0,0,0,0,0,0,0,1,1,1},
        {0,0,0,0,0,0,1,1,1,1},
        {0,0,0,0,0,1,1,1,1,1},
        {0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,-2,1,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,-2,1,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {1,1,1,1,1,0,0,1,1,1},
        {1,1,1,1,1,0,1,1,1,1},
        {1,1,1,1,1,0,1,1,1,1},
        {1,1,1,1,1,0,0,0,-2,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,1,0,0,1,1,1},
        {0,0,0,1,1,0,1,1,1,1},
        {0,0,1,1,1,0,1,1,1,1},
        {0,0,1,1,1,0,0,0,-2,1}},
        
       {{0,0,0,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,1,1,1},
        {0,0,0,0,0,0,1,1,1,1},
        {0,0,0,0,0,1,1,1,1,1},
        {0,0,0,0,-2,1,1,1,1,1}},
    };
    return chunks[int(random(chunks.length))];
}