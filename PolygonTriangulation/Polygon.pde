import java.util.Iterator;

class Polygon{
  public Polygon(ArrayList<Dot> dots){
    ArrayList<NamedDot> namedDots = new ArrayList<NamedDot>(dots.size());
    for(int i = 0; i < dots.size(); i++){
      namedDots.add(new NamedDot(dots.get(i), i)); 
    }
    this.dots = new DoubleLinkedList<NamedDot>(namedDots);
    this.trig = new ArrayList<Triangle>(dots.size() - 2);
    
    this.breakPoints = new boolean[dots.size()];
    
    triangulate();
  }
  
  public void show(){
    fill(255, 255, 0);
    beginShape();
    Iterator<NamedDot> d = dots.iterator();
    while(d.hasNext()){
      NamedDot curD = d.next();
      vertex(curD.x(), curD.y());
    }
    endShape(CLOSE);
    
    d = dots.iterator();
    while(d.hasNext()){
      NamedDot curD = d.next();
      if(breakPoints[curD.name()]){
        ellipse(curD.x(), curD.y(), 20, 20);
      }
      fill(0);
      text(curD.name(), curD.x(), curD.y());
      fill(255, 255, 0);
    }
  }
  
  public void showTrigs(){
    for(Triangle t: trig){
      t.show();
    }
  }
  
  private Dot getTheRightesDotIndex(){
    boolean flag = true;
    Dot theRight = null;
    
    Iterator<NamedDot> i = dots.iterator();
    while(i.hasNext()){
      // initializing the process
      if(flag){
        flag = false;
        theRight = i.next();
        continue;
      }
      
      Dot nxD = i.next();
      if(nxD.x() > theRight.x()){
        theRight = nxD;
      }
    }
    return theRight;
  }
  
  private float getDotOrientation(Dot d1, Dot d2, Dot d3){
    return d1.y()*(d3.x() - d2.x()) + d2.y()*(d1.x() - d3.x()) + d3.y()*(d2.x() - d1.x());
  }
  
  private int sign(float x){
    if(x == 0){
      return 0;
    }
    return (x > 0)? 1: -1;
  }
  
  private void findBreakPoints(DoubleLinkedList.DoubleIterator curDot){
    NamedDot d1 = (NamedDot)curDot.prev();
    curDot.next();
    NamedDot d2 = (NamedDot)curDot.next();
    NamedDot d3 = (NamedDot)curDot.next();

    initialDirection = sign(getDotOrientation(d1, d3, d2));
    while(initialDirection == 0){   
      d1 = d2;
      d2 = d3;
      d3 = (NamedDot)curDot.next();
      initialDirection = sign(getDotOrientation(d1, d3, d2));
    }
    boolean finish = false;
    println("init dir", initialDirection);
    
    while(!finish){
      if(!curDot.hasNext()){
        finish = true;
      }
      d1 = d2;
      d2 = d3;
      d3 = (NamedDot)curDot.next();
      
      if(! compareDirection(d1, d3, d2)){
        breakPoints[d2.name()] = true;
      }
    }
  }
  
  private boolean compareDirection(NamedDot d1, NamedDot d2, NamedDot d3){
    int orientation = sign(getDotOrientation(d1, d2, d3));
    return orientation == initialDirection || orientation == 0;
  }
  
  private void handleSidePoints(DoubleLinkedList breakList, DoubleLinkedList.ListNode[] breakListMap, NamedDot d1, NamedDot d2, NamedDot d3){
    if(compareDirection(d1, d2, d3)){
      if(breakListMap[d3.name()] != null){
        breakPoints[d3.name()] = false;
        breakList.removeNode(breakListMap[d3.name()]);
        breakListMap[d3.name()] = null;
      }
    } else {
      if(breakListMap[d3.name()] == null){
        breakPoints[d3.name()] = true;
        breakListMap[d3.name()] = breakList.addLast(new NamedDot(d3, d3.name()));
      }
    }
  }
  
  private void showDebugInfo(DoubleLinkedList breakList, NamedDot d1, NamedDot d2, NamedDot d3, boolean deleted){
    println(d1.name(), d2.name(), d3.name());
    println((deleted)? "was an ear": "was not an ear");
    println("break List(", breakList.size(), "): ");
    Iterator i = breakList.iterator();
    while(i.hasNext()){
      print(((NamedDot)i.next()).name(), " ");
    }
    println();
    println();
  }
  
  private boolean isEar(DoubleLinkedList breakList, Triangle curTrig){
    boolean res = true;
    Iterator i = breakList.iterator();
    while(i.hasNext()){
      NamedDot d = (NamedDot)i.next();
      if(curTrig.cotainsDot(d)){
        res = false;
        break;
      }
    }
    return res;
  }
  
  private void initializeContainers(DoubleLinkedList breakList, DoubleLinkedList.ListNode[] breakListMap){
    Iterator i = dots.iterator();
    while(i.hasNext()){
      NamedDot d = (NamedDot)i.next();
      if(breakPoints[d.name()]){
        NamedDot nwDot = new NamedDot(d, d.name());
        breakListMap[d.name()] = breakList.addLast(nwDot);
      }
    }
  }
  
  private void triangulate(){
    Dot right = getTheRightesDotIndex();
    DoubleLinkedList.DoubleIterator curDot = dots.iterator(new NamedDot(right, -1));
    findBreakPoints(curDot);
    
    DoubleLinkedList<NamedDot> breakList = new DoubleLinkedList();
    DoubleLinkedList.ListNode[] breakListMap = new DoubleLinkedList.ListNode[breakPoints.length];
    initializeContainers(breakList, breakListMap);
    
    int trianglesLeft = breakPoints.length - 2;
    curDot.updateIterator(); // the useless opereation
    NamedDot d1 = (NamedDot)curDot.next();
    NamedDot d2 = (NamedDot)curDot.next();
    NamedDot d3 = (NamedDot)curDot.next();
    
    while(trianglesLeft > 0){      
      boolean delAtCurOperation = false;
      if(!breakPoints[d2.name()]){
        Triangle curTrig = new Triangle(d1, d2, d3);
       
        if(isEar(breakList, curTrig)){
          trig.add(curTrig);
          delAtCurOperation = true;
          trianglesLeft --;
          
          NamedDot d4 = (NamedDot)curDot.next();
          for(int k = 0; k < 4; k++) curDot.prev();
          NamedDot d0 = (NamedDot)curDot.prev();      // curDot is on 0 position now
          for(int k = 0; k < 2; k++) curDot.next();   
          curDot.remove();                           // removing the ear
          curDot.next();                             // curDot is in its initial state
          
          if(trianglesLeft > 0){
            handleSidePoints(breakList, breakListMap, d0, d3, d1);
            handleSidePoints(breakList, breakListMap, d1, d4, d3);
          }
        }
      }
      showDebugInfo(breakList, d1, d2, d3, delAtCurOperation);
      if(delAtCurOperation){
        d2 = d3;
        d3 = (NamedDot)curDot.next();
      } else {
        d1 = d2;
        d2 = d3;
        d3 = (NamedDot)curDot.next();
      }
    }
  }
  
  private int initialDirection;
  private boolean[] breakPoints;
  private ArrayList<Triangle> trig;
  private DoubleLinkedList<NamedDot> dots;
}