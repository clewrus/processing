
class Rectangle extends Particle{
  Rectangle(){
    super();
  }
  
  public void say(){
    println("Rectangle");
  }
  
  public void show(){
    rect(pos.x, pos.y, 20, 20);
  }
}