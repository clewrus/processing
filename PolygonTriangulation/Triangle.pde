class Triangle{
  public Triangle(Dot v1, Dot v2, Dot v3){
    dots = new Dot[3];
    dots[0] = v1;
    dots[1] = v2;
    dots[2] = v3;
    initialColor = color(random(100, 255), random(100, 255), random(100, 255));
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
    if(!between(min(dots[0].x(), dots[1].x(), dots[2].x()), max(dots[0].x(), dots[1].x(), dots[2].x()), d.x())) return false;
    if(!between(min(dots[0].y(), dots[1].y(), dots[2].y()), max(dots[0].y(), dots[1].y(), dots[2].y()), d.y())) return false;
    if(onALine(dots[0], dots[1], d) || onALine(dots[1], dots[2], d) || onALine(dots[2], dots[0], d)) return false;
    float A = (d.y() - dots[0].y()) / (d.x() - dots[0].x());
    float B = (dots[2].y() - dots[1].y()) / (dots[2].x() - dots[1].x());
    float X = (dots[1].y() - dots[0].y() + dots[0].x() * A - dots[1].x() * B) / (A - B);
    return between(dots[1].x(), dots[2].x(), X);
  }
  
  private boolean onALine(Dot a, Dot b, Dot x){
    return abs((x.x() - a.x()) * (b.y() - a.y()) - (x.y() - a.y()) * (b.x() - a.x())) < 0.00001;
  }
  
  private boolean between(float a, float b, float x){
    return x > min(a, b) && x < max(a, b);
  }
  
  private color initialColor;
  private Dot[] dots;
}