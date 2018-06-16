class StartPage extends ContentPage{
  StartPage(int pageId){
    super(pageId);
  }
  
  protected void setupPGraph(){
    PrettyButton but1 = new PrettyButton(100, 100, 400, 200, "hey");
    but1.setParrentCanvas(pageGraph);
    but1.setEvent(new HelloEvent());
    but1.setColor(color(3,59,99));
    prettyArray.add(but1);
    
  }
  
  protected void updatePGraph(){
    for(PrettyElement e: prettyArray){
      e.show();
    }
  }

}

class HelloEvent extends PrettyEvent{
  public void onClick(){
    println("Hello world");
  }
}