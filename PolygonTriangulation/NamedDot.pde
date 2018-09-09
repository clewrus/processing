
class NamedDot extends Dot{
  NamedDot(Dot d, int name){
    super(d.x(), d.y());
    this.name = name;
  }
  
  public boolean eq(Dot d){
    return x() == d.x() && y() == d.y();
  }
  
  int name(){
    return name;
  }
  
  private int name;
}