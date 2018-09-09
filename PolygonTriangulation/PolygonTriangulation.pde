ArrayList<Dot> dots;
Polygon myPolygon;
color butColor = color(10, 200, 55);
boolean showingTheResult = false;

void setup(){
  size(600, 600);
  dots = new ArrayList<Dot>();
}

void draw(){
  background(180);
  if(showingTheResult){
    //myPolygon.show();
    myPolygon.showTrigs();
  } else {
    showDotPolygon();
  }
  
  // showing the button
  fill(butColor);
  ellipse(width - 80, height - 80, 80, 80);
  
}

void mouseClicked(){
  if(showingTheResult) return;
  
  if(dist(width - 80, height - 80, mouseX, mouseY) < 40){
    butColor = color(90, 90, 90);
    triangulate();
  } else {
    Dot nwDot = new Dot(mouseX, mouseY);
    dots.add(nwDot);
  }
}

void showDotPolygon(){
  fill(150, 150, 150);
    beginShape();
    for(Dot d: dots){
      vertex(d.x(), d.y());
    }
    endShape(CLOSE);
    
    for(int d = 0; d < dots.size(); d++){
      fill(255, 0, 0);
      ellipse(dots.get(d).x(), dots.get(d).y(), 10, 10);
      fill(0);
      text(d, dots.get(d).x()+ 5, dots.get(d).y() - 10);
    }
}

void triangulate(){
  myPolygon = new Polygon(dots);
  showingTheResult = true;
}