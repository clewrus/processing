class Tube extends Element{
  Tube(){
    super();
    int range = height - 2 * padding - holeHeight; // coordinate between padding and height-padding-tubeHeight
    bottomTubeY = (int)random(range) + padding + holeHeight;
  }
  
  public void update(){
    pos.add(vel);
  }
  
  public void show(){
    rect(pos.x, bottomTubeY, tubeWidth, height);
    rect(pos.x, bottomTubeY - holeHeight, tubeWidth, -height);
  }
  
  public void setPadding(int padding){
    this.padding = padding;
  }
  
  public boolean offScreen(){
    return pos.x + tubeWidth < 0;
  }
  
  public boolean checkCollision(Bird bird){
    int radius = bird.getRadius();
    PVector birdPos = bird.getPosition();
    // imagine that bird is square width edge equals to 1.7 * radius
    
    // bird's vertexes
    PVector topLeft = new PVector(birdPos.x - radius * 0.85, birdPos.y - radius * 0.85);
    PVector botRight = new PVector(birdPos.x + radius * 0.85, birdPos.y + radius * 0.85);
    
    PVector bTopLeft = new PVector(pos.x, bottomTubeY);
    PVector bBotRight = new PVector(pos.x + tubeWidth, height);
    
    PVector tTopLeft = new PVector(pos.x, 0);
    PVector tBotRight = new PVector(pos.x + tubeWidth, bottomTubeY - holeHeight);
    
    return rectCollision(topLeft, botRight, bTopLeft, bBotRight) || rectCollision(topLeft, botRight, tTopLeft, tBotRight);
    
  }
  
  private boolean rectCollision(PVector a1, PVector a2, PVector b1, PVector b2){
    return ((a1.x > b1.x && a1.x < b2.x) || (a2.x > b1.x && a2.x < b2.x)) && ((a1.y > b1.y && a1.y < b2.y) || (a2.y > b1.y && a2.y < b2.y));
  }
  
  public void setVelosity(PVector vel){
    this.vel = vel;
  }
  
  public void setHoleHeight(int holeHeight){
    this.holeHeight = holeHeight;
  }
  
  public void setTubeWidth(int tubeWidth){
    this.tubeWidth = tubeWidth;
  }
  
  private int padding = 50;
  private int holeHeight = 200;
  private int tubeWidth = 80;
  private int bottomTubeY;
  
  private PVector vel = new PVector(-2, 0);
  private PVector pos = new PVector(width, 0); // position of the left top corner
}