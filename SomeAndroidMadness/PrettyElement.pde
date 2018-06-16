abstract class PrettyElement{
  PrettyElement(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2; 
  }
  
  // draws the element
  abstract public void show();
  
  abstract public void setEvent(PrettyEvent e);
  
  abstract public boolean handleClick();
  
  // sets the PGraphics object which is related to this one
  void setParrentCanvas(PGraphics pGraph){
    this.pGraph = pGraph;
  }
  
  PGraphics pGraph;
  public float x1, y1;
  public float x2, y2;
}