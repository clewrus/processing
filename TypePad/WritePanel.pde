class WritePanel extends Panel{
  
  WritePanel(Text text, int textPnt, int xPos, int yPos, int maxLength, int rows, int charSize){
    super(text, textPnt, xPos, yPos, maxLength, rows, charSize);
    
    targetRow = rows - 1;
    table = new char[rows][maxLength];
    formStartTable();
    trashBox = new Stack<char[]>();
  }
  
  void describe(){
    
  }
  
  void setRemarkMenu(RemarkMenu menu){
    this.remark = menu;
  }
  
  void formStartTable(){
    int pnt = textPnt;
    while(pnt >= 0 && text.text.charAt(pnt) != ' '){
      pnt--;
    }
    pnt = (pnt < 0) ? 0 : pnt;
    int startLine = pnt + 1;
    
    for(int i = targetRow - 1; i >= 0; i--){
      TextBLine t = new TextBLine(text, pnt, maxLength);
      table[i] = t.line;
      pnt = t.getPrevPoint();
      startPanelPnt = pnt;
    }
    
    curPnt = textPnt - startLine;
    for(int i = 0; i <= curPnt; i++){
      table[targetRow][i] = text.text.charAt(startLine + i);
    }
    for(int i = curPnt+1; i< maxLength; i++){
      table[targetRow][i] = '*';
    }
  }
  
    void show(){
    PVector pnt = pos.copy();
    for(char[] l : table){
      fill(255);
      text(new String(decorated(l.clone())), pnt.x, pnt.y);
      pnt.y += charSize + 5;
    }
  }
  
  
  void symAdd(char a){
    if(!isAddKey(a))return;
    curPnt++;
    textPnt++;
    if(remark != null){
      remark.symAdd(a, textPnt);
    }
    handleOverflow();
    
    table[targetRow][curPnt] = a;
  }
  
  void prevLine(){
    for(int i = rows - 1; i > 0; i--){
      table[i] = table[i - 1].clone();
    }
    if(!trashBox.empty()){
      table[0] = trashBox.pop();
    }else{
      table[0] = new TextBLine(text, startPanelPnt, maxLength).line;
   
    }
    curPnt = lineEnd(table[targetRow]);
    startPanelPnt = new TextBLine(text, startPanelPnt,maxLength).getPrevPoint();

    
  }
  
  void symDelete(){
    if(curPnt == -1) return;
    table[targetRow][curPnt] = '*';
    super.symDelete();
    
  }
  
  void handleOverflow(){
    if(curPnt == maxLength){
      trashBox.push(table[0]);
      for(int i = 1; i < rows; i++){
        table[i-1] = table[i];
      }
      curPnt = 0;
      table[targetRow] = new char[maxLength];
      for(int g = 0; g < maxLength; g++){
        table[targetRow][g] = '*';
      }
      int j;
      for(j = maxLength - 1; table[targetRow - 1][j] != ' ';){
        j--;
        if(j - 1 < 0) break;
      }
      if(j == 0) return;
      j++;
      for(curPnt = 0; j < maxLength; curPnt++, j++){
        table[targetRow][curPnt] = table[targetRow - 1][j];
        table[targetRow - 1][j] = '*';
      }
      startPanelPnt = new TextFLine(text, startPanelPnt+1,maxLength).getNextPoint()-1;
    }
  }

  Stack<char[]> trashBox;
  RemarkMenu remark;
}