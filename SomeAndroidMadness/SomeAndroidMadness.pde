ContentPage activePage;

// --------- variables -------------

void setup(){
  size(500, 500);
  //fullScreen();
  activePage = new StartPage(1);
}

void draw(){
  activePage.showContentPage(); //<>//
}

void mouseClicked(){
  activePage.handleClick();
}