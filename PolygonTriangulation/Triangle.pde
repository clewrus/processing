class Triangle{
  public Triangle(Dot v1, Dot v2, Dot v3){
    dots = new Dot[3];
    dots[0] = v1;
    dots[1] = v2;
    dots[2] = v3;
    initialColor = color(random(100, 255), random(100, 255), random(100, 255));
    
    float X = (dots[0].x() + dots[1].x() + dots[2].x()) / 3.0;
    float Y = (dots[0].y() + dots[1].y() + dots[2].y()) / 3.0;
    centerVec = new PVector(X, Y);
    
    centeredDots = new Dot[3];
    for(int i = 0; i < 3; i++){
      centeredDots[i] = getCenteredDot(dots[i]);
    }
  }
  
  public void show(color c){
    fill(c);
    beginShape();
    for(int i = 0; i < 3; i++){
      vertex(dots[i].x(), dots[i].y());
    }
    endShape(CLOSE);
  }
  
  public void show(){
    this.show(initialColor);
  }
  
  public boolean cotainsDot(Dot d){
    d = getCenteredDot(d);
    
    if(!underTheLine(centeredDots[0], centeredDots[1], centeredDots[2])) return false;
    
    for(int i = 0; i < 3; i++){
      if(!underTheLine(centeredDots[i], centeredDots[(i + 1) % 3], d)) return false;
    }
    
    return true;
  }
  
  
  
  private Dot getCenteredDot(Dot a){
    return new Dot(a.x() - centerVec.x, a.y() - centerVec.y);
  }
  
  // returns true if the dot x is laing at the same half-flat as the zero point
  private boolean underTheLine(Dot a, Dot b, Dot x){
    float delta = (x.x() - a.x()) * (b.y() - a.y()) - (x.y() - a.y()) * (b.x() - a.x());
    int s1 = sign(delta);
    int s2 = sign(a.y() * b.x() - a.x() * b.y());
    return s1 == s2 && abs(delta) > 0.0001f;
  }
  
  private int sign(float x){
    return (x > 0) ? 1 : -1;
  }
  
  private color initialColor;
  private Dot[] dots;
  
  private PVector centerVec;
  private Dot[] centeredDots;
}