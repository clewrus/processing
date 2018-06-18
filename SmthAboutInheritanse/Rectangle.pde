
class Rectangle extends Particle{
  Rectangle(){
    super();
  }
  
  public void say(){
    println("Rectangle");
  }
  
  public void show(){
    fill(myColor);
    rect(pos.x, pos.y, 20, 20);
  }
}