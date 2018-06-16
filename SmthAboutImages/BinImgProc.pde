import java.util.Stack;
import java.util.ArrayList;

class BinImgProc extends BinaryImage{
  BinImgProc(BinaryImage img){
    super(img.getWidth(), img.getHeight());
    this.InitialImage = img.getPixArr();
  }
  
  public PImage toPImage(){
    PImage result = new PImage(width_, height_);
    result.loadPixels();
    for(int i = 0; i < result.pixels.length; i++){
      result.pixels[i] = (InitialImage[i])? color(255) : color(0);
    }
    return result;
  }
  
  public boolean[] disk(int diameter){
    boolean[] matrix = new boolean[diameter * diameter];
    float centerP = diameter / 2;
    float maxRadius = dist(centerP, centerP, 0.0, centerP - 1);
    
    for(int i = 0; i < diameter * diameter; i ++){
      float distanse = dist(centerP, centerP, (float)(i % diameter), (float)(i / diameter));
      matrix[i] = maxRadius >= distanse;
    }
    return matrix;
  }
  
  public void dilatation(boolean[] mask){
    clearPixArr();
    int diameter = (int)sqrt((float)mask.length);
    for(int i = 0; i < len; i++){
      if(!InitialImage[i]){
        continue;
      }
      int curX = i % width_;
      int curY = i / width_;
      
      for(int j = 0; j < mask.length; j ++){
        int relX = j % diameter - diameter / 2;
        int relY = j / diameter - diameter / 2;
        
        int X = curX + relX; 
        int Y = curY + relY;
        
        X = (X >= 0)? (X < width_)? X: width_ - 1 : 0;
        Y = (Y >= 0)? (Y < height_)? Y: height_ - 1 : 0;
        
        int targetI = Y * width_ + X;
        pixArr[targetI] = (InitialImage[targetI] || mask[j] || pixArr[targetI]);
      }
    }
    saveImage();
  }
  
  public void erosion(boolean[] mask){
    int diameter = (int)sqrt((float)mask.length);
    for(int i = 0; i < len; i++){
      boolean value = true;
      int curX = i % width_;
      int curY = i / width_;
      if(!InitialImage[i]){
        continue;
      }
      
      for(int j = 0; j < mask.length; j ++){        
        int relX = j % diameter - diameter / 2;
        int relY = j / diameter - diameter / 2;
        
        int X = curX + relX; 
        int Y = curY + relY;
        
        X = (X >= 0)? (X < width_)? X: width_ - 1 : 0;
        Y = (Y >= 0)? (Y < height_)? Y: height_ - 1 : 0;
        
        int targetI = Y * width_ + X;
        if(!InitialImage[targetI] && mask[j]){
          value = false;
          break;
        }
      }
      pixArr[i] = value;
    }
    saveImage();
  }
  
  public void smoothEdges(int size){
    boolean[] disk_ = disk(size);
    erosion(disk_);
    dilatation(disk_);
  }
  
  public void restoreImage(){
    for(int i = 0; i < len; i++){
      pixArr[i] = InitialImage[i];
    }
  }
  
  public void saveImage(){
    InitialImage = pixArr;
    pixArr = new boolean[len];
  }
  public BinaryImage toBinImage(){
    BinaryImage img = new BinaryImage(width_, height_);
    boolean[] arr = new boolean[len];
    for(int i = 0; i < len; i++){
      arr[i] = InitialImage[i];
    }
    img.setPixArr(arr);
    return img;
  }
  
  private void clearPixArr(){
    for(int i = 0; i < 0; i++ ){
      pixArr[i] = false;
    }
  }
  // ------------------------------------------------------------
  private int findFreeCell(short[] classMap, int lastTarget){
    for(int i = lastTarget; i < classMap.length; i++){
      if( classMap[i] == 0){
        return i;
      }
    }
    return -1;
  }
  
  private ClassMap getClassMap(boolean[] binImg, int width_, int height_){
    println("getClassMap", width_, binImg.length);
    short[] classMap = new short[binImg.length];
    ArrayList<Integer> classesIndexes = new ArrayList();
    Stack<Integer> waitingCells = new Stack();
    
    int lastTarget = 0;
    int targetI = findFreeCell(classMap, lastTarget);//have lo memorise the last stand
    lastTarget = targetI;
    short groupIndex = 0;
    boolean curGroupValue;
    while(targetI != -1){
      classesIndexes.add(targetI);
      groupIndex++;
      println(groupIndex, targetI);
      curGroupValue = binImg[targetI];
      waitingCells.push(targetI);
      while(!waitingCells.empty()){
        classMap[targetI] = groupIndex;
        int[] neighbors = getNeighborI(targetI, width_, height_);
        
        for(int i = 0; i < neighbors.length; i++){
          int curIndex = neighbors[i];
          if(classMap[curIndex] == 0 && binImg[curIndex] == curGroupValue){
            waitingCells.push(curIndex);
          }
        }
        targetI = waitingCells.pop();
      }
      targetI = findFreeCell(classMap, lastTarget);
      lastTarget = targetI;
    }
    println("end looping groups: ", groupIndex);
    Integer[] a = new Integer[classesIndexes.size()];
    return new ClassMap(classMap, classesIndexes.toArray(a), width_);
  }
  
  private int[] getEdgeCells(int width_, int height_){
    int fullPath = 2 * width_ + 2 * (height_ - 2);
    int[] edgeCells = new int[fullPath];
    int x = -1;
    int y = 0;
    // 0-right 1-down 2-left 3-up
    int direction = 0;
    for(int i = 0; i < edgeCells.length; i++){
      if(direction == 0) x++;
      if(direction == 1) y++;
      if(direction == 2) x--;
      if(direction == 3) y--;
      
      if(direction == 0 && x == width_){
        x = width_ - 1;
        y = 1;
        direction = 1;
      }
      if(direction == 1 && y == height_){
        y = height_ - 1;
        x = width_ - 2;
        direction = 2;
      }
      if(direction == 2 && x == -1){
        x = 0;
        y = height_ - 2;
        direction = 3;
      }
      if(direction == 3 && y == 0){
        break;
      }
      edgeCells[i] = y * width_ + x;
    }
    return edgeCells;
  }
  
  private void fillWithZeros(short[] classMap, int index){
    boolean[] visitedCells = new boolean[classMap.length];
    Stack<Integer> waitingCells = new Stack();
    waitingCells.push(index);
    short figureIndex = classMap[index];
    while(!waitingCells.empty()){
      int curI = waitingCells.pop();
      if(visitedCells[curI]){
        continue;
      }
      classMap[curI] = 0;
      visitedCells[curI] = true;
      int[] neighbors = getNeighborI(curI, width_, height_);
      for(int i = 0; i < neighbors.length; i++){
        int targetI = neighbors[i];
        if(classMap[targetI] == figureIndex && !visitedCells[targetI]){
          waitingCells.push(targetI);
        }
      }
    }
  }
  
  private void nullSideSymbols(short[] classMap, int width_, int height_){
    println("nullSideSymbols");
    int[] edgeCells = getEdgeCells(width_, height_);
    
    for(int index: edgeCells){
      if(classMap[index] == 0){
        continue;
      }
      fillWithZeros(classMap, index);
    }
  }
  
  private Integer[] deleteZeroClass(Integer[] classI, short[] classMap){
    ArrayList<Integer> newClassI = new ArrayList<Integer>();
    for(int index: classI){
      if(classMap[index] != 0){
        newClassI.add(index);
      }
    }
    Integer[] a = new Integer[newClassI.size()];
    return newClassI.toArray(a);
  }
  
  private int getInnerI(short[] classMap, int index, int width_){
    boolean touchsZero = false;
    int res = -1;
    int curClass = classMap[index];
    
    Stack<Integer> waitingCells = new Stack<Integer>();
    waitingCells.push(index);
    boolean[] visitedCells = new boolean[classMap.length];
    while(!waitingCells.empty()){
      int curI = waitingCells.pop();
      if(visitedCells[curI]) continue;
      visitedCells[curI] = true;
      
      int[] neighbors = getNeighborI(curI, width_, height_);
      for(int neighborI: neighbors){
        if(classMap[neighborI] == 0){
          touchsZero = true;
          continue;
        }
        if(classMap[neighborI] != curClass){
          res = neighborI;
          break;
        }
        if(classMap[neighborI] == curClass && !visitedCells[neighborI]){
          waitingCells.push(neighborI);
        }
      }
    }
    return (touchsZero) ? res : -1;
  }
  
  private void nullInnerClasses(ClassMap infoMap, int width_){
    short[] classMap = infoMap.classMap;
    Integer[] classI = infoMap.classesIndexes;
    
    boolean haveInnerNulls = true;
    while(haveInnerNulls){
      haveInnerNulls = false;
      for(int index: classI){
        int innerI = getInnerI(classMap, index, width_);
        if(innerI == -1){
          continue;
        }
        haveInnerNulls = true;
        fillWithZeros(classMap, innerI);
        classI = deleteZeroClass(classI, classMap);
        infoMap.classesIndexes = classI;
      }
    }
  }
  
  public BinarySymbol[] parseSymbols(){
    // get the class separated integer map
    ClassMap infoMap = getClassMap(this.InitialImage, this.width_, this.height_);
    short[] classMap = infoMap.classMap;
    Integer[] classI = infoMap.classesIndexes;
    
    nullSideSymbols(classMap, this.width_, this.height_);
    infoMap.classesIndexes = deleteZeroClass(classI, classMap);
    
    nullInnerClasses(infoMap, this.width_);
    classI = infoMap.classesIndexes;
    BinarySymbol[] symbols = new BinarySymbol[classI.length];    
    
    for(int i = 0; i < classI.length; i++){
      symbols[i] = new BinarySymbol(infoMap, classI[i]);
    }
    return symbols;
  }

  // ------------------------------------------------------------
  
  
  private boolean[] InitialImage;
}