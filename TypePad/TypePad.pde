import java.io.FileReader;

int CHAR_SIZE = 20;
int START_PNT = 0;
String pathName = "/home/clewrus/sketchbook/TypePad";

ReadPanel rPanel;
WritePanel wPanel;
RemarkMenu rMenu;

void setup(){
  size(700, 600);
  // widrt / size = 0.6
  PFont font = createFont("DroidSansMono.ttf", CHAR_SIZE);
  textFont(font);
  loadSave();
  
  background(150);
  Text HofB = new Text(pathName, "text.txt");
  
  wPanel = new WritePanel(HofB, START_PNT, 50, 300, 50, 3, CHAR_SIZE); 
  rPanel = new ReadPanel(HofB, START_PNT, 50, 60, 50, 5, CHAR_SIZE);
  rMenu = new RemarkMenu(rPanel);
  wPanel.setRemarkMenu(rMenu);
}

void loadSave(){
    File saveFile = new File(pathName, "save.txt");
  try{
     BufferedReader read = new BufferedReader(new FileReader(saveFile));
     START_PNT = Integer.parseInt(read.readLine());
     read.close();
  }catch(Exception hey){
    println(hey);
  }
}

void createSave(){
  File saveFile = new File(pathName, "save.txt");
  try{
    PrintWriter writer = new PrintWriter(saveFile, "UTF-8");
    writer.print(rPanel.textPnt+1);
    writer.close();
  }catch(Exception hey){
    println(hey);
  }   
}

void draw(){
  background(150);
  rPanel.showMistakes();
  rPanel.show();
  wPanel.show();
}

void keyPressed(){
  // I am going to save every word
  if((char)key == ' '){
    createSave();
  }
  rPanel.handleKeyEvent((int)key);
  wPanel.handleKeyEvent((int)key);
  
}