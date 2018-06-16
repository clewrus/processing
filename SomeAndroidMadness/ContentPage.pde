abstract class ContentPage{
  ContentPage(int pageId){
    this.pageId = pageId;
    this.pageGraph = createGraphics(width, height);
    prettyArray = new ArrayList<PrettyElement>();
    setupPGraph();
  }
  
  // in this method you have to fill in thi pageGraph obfect for the first time
  abstract protected void setupPGraph();
  
  // in this method you have to update the pageGraph object if it is needed
  abstract protected void updatePGraph();
  
  // use in draw loop to render page
  public void showContentPage(){
    updatePGraph();
    this.show();
    if(isAppearing){
      appearingProgress -= appearingSpeed;
      if(appearingProgress <= 0){
        isAppearing = false;
        backPage = null;
      }
    }
  }
  
  // this method is used in show and handleClick functions
  private float getBorderX(){
    return map(appearingProgress, APPEARING_START_POINT, 0, width, 0);
  }
  
  // while appearing shows background in the first order
  // and then shows this.pageGraph
  protected void show(){
    if(isAppearing){
      backPage.showContentPage();
      float x = getBorderX();
      image(pageGraph, x, 0);
    }else{
      image(pageGraph, 0, 0);
    }
  }
  
  public boolean handleClick(){
    if(isAppearing){
      float x = getBorderX();
      if(mouseX < x){
        return backPage.handleClick();
      }
    }
    for(PrettyElement e: prettyArray){
      boolean res = e.handleClick();
      if(res){
        return true;
      }
    }
    return false;
  }
  
  // initiate appearing process. The backPage sets the background page element
  public void startAppearOver(ContentPage backPage){
    this.backPage = backPage;
    isAppearing = true;
    appearingProgress = APPEARING_START_POINT;
  }
  
  public void setAppearingSpeed(float speed){
    appearingSpeed = speed;
  }
  
  public int getPageId(){
    return pageId;
  }
  
  private float APPEARING_START_POINT = 0.5;
  
  public ArrayList<PrettyElement> prettyArray;
  protected PGraphics pageGraph;
  private boolean isAppearing;
  private ContentPage backPage;
  private float appearingProgress;
  private float appearingSpeed = 0.1;
  
  private int pageId;
}