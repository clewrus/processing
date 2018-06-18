import java.util.Iterator;

ArrayList<Element> tubes;
Element bird;
boolean endGame = false;

int TUBES_PERIOD = 300; // number of frames between adding a new tube

void setup(){
  size(900, 600);
  tubes = new ArrayList<Element>();
  bird = new Bird();
}

void draw(){
  if(endGame) return;
  
  background(200);
  if(frameCount % TUBES_PERIOD == 0){
    Element tube = new Tube();
    tubes.add(tube);
  }
  
  bird.show();
  for(Element el : tubes){
    el.show();
  }
  
  bird.update();
  if(((Bird)bird).getPosition().y > height - ((Bird)bird).getRadius()){
    endGame();
  }
  
  Iterator<Element> iter = tubes.iterator();
  while(iter.hasNext()){
    Tube el = (Tube)iter.next();
    el.update();
    
    if(el.offScreen()){
      tubes.remove(el);
    }
    
    if(el.checkCollision((Bird)bird)){
      handleCollision(el);
    }
  }
}

void handleCollision(Element el){
  fill(255, 0, 0);
  ((Tube)el).show();
  endGame();
}

void endGame(){
  endGame = true;
  noLoop();
  fill(0);
  textSize(100);
  text("Game over", width / 2 - 260, height / 2 + 20);
  textSize(50);
  text("Click to play more", width / 2 - 220, height / 2 + 80);
  fill(255);
}

void mouseClicked(){
  if(endGame){
    endGame = false;
    setup();
    loop();
  }
}

void keyPressed(){
  if(key == ' '){
    ((Bird)bird).push();
  }
}