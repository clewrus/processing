
class PrettyButton extends PrettyElement{
  PrettyButton(float x1, float y1, float x2, float y2, String text){
    super(x1, y1, x2, y2);
    this.text = text;
    
  }
  
  public void show(){
    pGraph.beginDraw();
    pGraph.pushMatrix();
    pGraph.noStroke();
    if(!isAnimating){
      pGraph.fill(butColor);
    }else{
      float k = animatingProgress;
      animatingProgress += animatingSpeed;
      if(animatingProgress >= 1){
        isAnimating = false;
        animatingProgress = 1;
      }
      pGraph.fill(red(butColor) * k, green(butColor) * k, blue(butColor) * k, 255 * k);
    }
    pGraph.rect(x1, y1, x2 - x1, y2 - y1, min(x2 - x1, y2 - y1) * 0.1);
    pGraph.popMatrix();
    pGraph.endDraw();
  }
  
  public void setEvent(PrettyEvent e){
    this.onClickEvent = e;
  }
  
  private boolean isMouseOver(){
    return mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2;
  }
  
  public boolean handleClick(){
    if(! isMouseOver()){
      return false;
    }else {
      startAnimating();
      onClickEvent.onClick();
      return true;
    }
  }
  
  public void setColor(color c){
    butColor = c;
  }
  
  public void setAnimatingSpeed(int s){
    this.animatingSpeed = s;
  }
  
  private void startAnimating(){
    isAnimating = true;
    animatingProgress = ANIMATION_START_POINT;
  }
  
  private float ANIMATION_START_POINT = 0.5;
  private PrettyEvent onClickEvent;
  private boolean isAnimating;
  private float animatingProgress;
  private float animatingSpeed = 0.05;
  public color butColor;
  public String text;
}