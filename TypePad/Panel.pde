abstract class Panel extends Menu{
  Panel(Text text, int textPnt, int xPos, int yPos, int maxLength, int rows, int charSize){
    super(maxLength, rows);
    this.text = text;
    this.textPnt = textPnt;
    pos = new PVector(xPos, yPos);
    this.charSize = charSize; 
  }

  abstract void symAdd(char  c);
  
  void handleKeyEvent(int butt){
    if(butt == 8){
      symDelete();
    }
    else{
      symAdd((char)butt);
    }

  }
  
  char[] decorated(char[] c){
  for(int i = maxLength; !Character.isLetter(c[i-1]);){
    if(c[i-1] == '*')c[i-1] = ' ';
    i--;
    if(i - 1 < 0){
      return c;
    }
  }
  return c;
  }
  
  abstract void prevLine();
  
  
  char[][] table;
  PVector pos;

  int endPanelPnt;
  int startPanelPnt;
  int charSize;
  int targetRow;
}