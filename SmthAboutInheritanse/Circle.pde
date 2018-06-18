
class Circle extends Particle{
  Circle(){
    super();
  }
  
  public void show(){
    fill(myColor);
    ellipse(pos.x, pos.y, 50, 50);
  }
  
  public void sayIAmCircle(){
    println("I am your tiny little particle");
  }
}