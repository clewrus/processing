class Rope{
  Rope(float x1, float y1, float x2, float y2, float stiffness){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.stiffness = stiffness;
    ropeLength = dist(x1, y1, x2, y2);
  }
  
  PVector getForceVector(){
    PVector f = new PVector(x2 - x1, y2 - y1);
    float deltaLength = dist(x1, y1, x2, y2) - ropeLength;
    if(deltaLength < 0){
      deltaLength = 0;
    }
    f.mult(-1.0 * stiffness * deltaLength);
    println(x1, y1, x2, y2, ropeLength, deltaLength);
    return f;
  }
  
  void show(){
    line(x1, y1, x2, y2);
    ellipse(x1, y1, 10, 10);
  }
  
  void setPos(float x, float y){
    x2 = x;
    y2 = y;
  }
  
  private float ropeLength;
  private float x1;
  private float y1;
  private float x2;
  private float y2;
  private float stiffness;
}