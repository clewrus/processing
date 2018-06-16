

class ReadPanel extends Panel{
  ReadPanel(Text text, int textPnt, int xPos, int yPos, int maxLength, int rows, int charSize){
    super(text, textPnt, xPos, yPos, maxLength, rows, charSize);
    trashBox = new Stack<char[]>();
    endPnt = new Stack<Integer>();
    formStartTable();
  }

  
  void highlight(PVector p, int mode){
    pushMatrix();
    if(mode == 0)
      fill(0, 255, 0, 80);
      else if(mode == 1)
      fill(255, 0, 0, 80);
    noStroke();
    rect(p.x, p.y+5, charSize*0.6, -charSize-5);
    popMatrix();
  }
  
  void formStartTable(){
    table = new char[rows][maxLength];
    targetRow = (rows + 1) / 2;
    int lineStart = textPnt;
    
    while(text.text.charAt(lineStart) != ' ' && lineStart > 0){
      lineStart--;
    }
    lineStart = (lineStart < 0)?0:lineStart+1;
    
    int curStart = lineStart;
    curPnt = textPnt - curStart;
    for(int i = targetRow; i < rows; i++){
      TextFLine f = new TextFLine(text, curStart, maxLength);
      table[i] = f.line;
      curStart = f.getNextPoint();
      
    }
    endPanelPnt = curStart-1;
    
    curStart = lineStart - 1;
    for(int i = targetRow - 1; i >= 0; i--){
      TextBLine b = new TextBLine(text, curStart, maxLength);
      table[i] = b.line;
      curStart = b.getPrevPoint();
      
    }
    startPanelPnt = curStart;
    
  }
  
  void handleOverflow(){
    if(curPnt > lineEnd(table[targetRow])){
      trashBox.push(table[0].clone());
      for(int i = 1; i < rows; i++){
        table[i-1] = table[i];
      }
      endPnt.push(endPanelPnt);
      TextFLine f = new TextFLine(text, endPanelPnt+1, maxLength);
      table[rows-1] = f.line;
      endPanelPnt = f.getNextPoint()-1;
      curPnt = 0;
      
      startPanelPnt = new TextFLine(text, startPanelPnt+1,maxLength).getNextPoint()-1;
      
      rMenu.nextLine();
    }
  }
  
  void show(){
    PVector rPnt = pos.copy();
    boolean[][] remark = rMenu.table;
    float symLen = charSize * 0.6;
    for(int i = 0; i < rows; i++){
      char[] c = table[i];
      int eP = 0;
      PVector curPnt = rPnt.copy();
      while(eP <= lineEnd(c)){
        if(remark[i][eP]||(i>targetRow)||(i == targetRow && eP > this.curPnt)){
          fill(255);
          text(c[eP], curPnt.x, curPnt.y);
        }else{
          fill(255, 0, 0);
          text(c[eP], curPnt.x, curPnt.y);
        }
        curPnt.x += symLen;
        eP++;
      }
      rPnt.y += charSize + 5;
    }
  }
  
  void symAdd(char c){
    if(!isAddKey(c)) return;
    curPnt++;
    textPnt++;
    handleOverflow();
  }
  
  void symDelete(){
    super.symDelete();
    rMenu.symDelete();
  }
  
  void showMistakes(){
    boolean[][] remark = rMenu.table;
    PVector pnt = pos.copy();
    for(int i = 0; i < targetRow; i++){
      int endInd = lineEnd(table[i]);
      PVector anthPnt = pnt.copy();
      for(int j = 0; j <= endInd; j++){
        if(endInd == 0) continue;
        int mode = remark[i][j]? 0 : 1;
        highlight(anthPnt, mode);
        anthPnt.x += charSize * 0.6;
      }
      pnt.y += charSize + 5;
    }
    for(int i = 0; i <= curPnt; i++){
      int mode = remark[targetRow][i]? 0 : 1;
      highlight(pnt, mode);
      pnt.x += charSize * 0.6;
    }
  }
  
  void prevLine(){
    for(int i = rows - 2; i >= 0; i--){
      table[i+1] = table[i].clone();
    }
    
    TextBLine b = new TextBLine(text, startPanelPnt, maxLength);
    if(!trashBox.empty()){
      table[0] = trashBox.pop();
    }else{
      table[0] = b.line;
    }
    startPanelPnt = b.getPrevPoint();
    curPnt = lineEnd(table[targetRow]);
    if(!endPnt.empty()){
      endPanelPnt = endPnt .pop();
    }else{
      TextBLine n = new TextBLine(text, endPanelPnt, maxLength);
      endPanelPnt = n.getPrevPoint();
    }
  }
  
  RemarkMenu rMenu;
  Stack<char[]> trashBox;
  Stack<Integer> endPnt;

}