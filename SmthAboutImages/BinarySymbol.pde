import java.util.Stack;
class BinarySymbol extends BinaryImage{
  BinarySymbol(ClassMap parentClassMap, int classIndex){
    super();
    this.parentClassMap = parentClassMap;
    this.classIndex = classIndex;
    this.classNumber = parentClassMap.classMap[classIndex];
    this.edges = new int[4];
    //edges[0] = edges[1] = edges[2] = edges[3] = classIndex;
    edges[0] = edges[1] = classIndex / parentClassMap.mapWidth;
    edges[2] = edges[3] = classIndex % parentClassMap.mapWidth;
    defindEdges();
    int edgeSize = max(edges[3] - edges[2] + 3, edges[1] - edges[0] + 3);
    initialize(edgeSize, edgeSize); 
    copyClassPicture();
  }
  
  private void defindEdges(){
    Stack<Integer> waitingCells = new Stack<Integer>();
    waitingCells.push(classIndex);
    short[] classMap = parentClassMap.classMap;
    boolean[] visitedCells = new boolean[classMap.length];
    
    while(!waitingCells.empty()){
      int curCell = waitingCells.pop();
      visitedCells[curCell] = true;
      checkForNewEdge(curCell);
      int[] neighbors = getNeighborI(curCell, parentClassMap.mapWidth);
      
      for(int index: neighbors){
        if(!visitedCells[index] && classMap[index] == classNumber){
          waitingCells.push(index);
        }
      }
    }
  }
  
  private void checkForNewEdge(int cellI){
    int x = cellI % parentClassMap.mapWidth;
    int y = cellI / parentClassMap.mapWidth;
    // 0-up 1-down 2-left 3-right
    if(x > edges[3]){
      edges[3] = x;
    }
    if(x < edges[2]){
      edges[2] = x;
    }
    if(y < edges[0]){
      edges[0] = y;
    }
    if(y > edges[1]){
      edges[1] = y;
    }
  }
  
  private void copyClassPicture(){
    int startX = edges[2] - 1;
    int startY = edges[0] - 1;
    int endX = edges[3] + 1;
    int endY = edges[1] + 1;

    if(endY - startY != endX - startX){
      int diff = endY - startY - (endX - startX);
      // it is taller
      if(diff > 0){
        startX -= diff / 2;
        endX += diff - diff / 2;
      }
      // it is widther
      if(diff < 0){
        startY -= -diff / 2;
        endY += -diff + diff / 2;
      }
    }
    
    for(int x = startX; x <= endX; x++){
      for(int y = startY; y <= endY; y++){
        int copyImageIndex = (y - startY) * width_ + x - startX;
        if( x < 0 || y < 0 || x >= parentClassMap.mapWidth || 
        y >= parentClassMap.classMap.length / parentClassMap.mapWidth){
          this.pixArr[copyImageIndex] = false;
        }
        int curIndex = y * parentClassMap.mapWidth + x;
        this.pixArr[copyImageIndex] = parentClassMap.classMap[curIndex] == classNumber;
      }
    }
  }
  
  private int[] edges; // 0-up 1-down 2-left 3-right
  protected int classNumber;
  protected ClassMap parentClassMap;
  protected int classIndex;
}