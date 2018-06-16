import java.util.Stack;

class RemarkMenu extends Menu{
  
  RemarkMenu(ReadPanel rPanel){
    super(rPanel.maxLength, rPanel.rows);
    this.text = rPanel.text;
    this.textPnt = rPanel.textPnt;
    this.rPanel = rPanel;
    this.trashBox = new Stack<boolean[]>();
    rPanel.rMenu = this;
    formTable();
    curLineEnd = lineEnd(rPanel.table[rPanel.targetRow]);
    this.curPnt = rPanel.curPnt;
  }
  

  
  void formTable(){
    table = new boolean[rows][maxLength];
    for(int i = 0; i < rPanel.targetRow; i++){
      for(int j = 0; j < maxLength; j++){
        table[i][j] = true;
      }
    }
    for(int i = 0; i <= rPanel.curPnt; i++){
      table[rPanel.targetRow][i] = true;
    }
  }
  
  void symAdd(char c, int pnt){
    textPnt++;
    if(textPnt != pnt) println("Something is wrong");
    curPnt++;
    // println(curPnt, rPanel.curPnt, textPnt, rPanel.textPnt, text.text.charAt(textPnt));
    table[rPanel.targetRow][curPnt] = text.text.charAt(textPnt) == c;
    //println(text.text.charAt(textPnt), c, curPnt, table[rPanel.targetRow][curPnt]);
  }
  
  void nextLine(){
    curPnt = -1;
    trashBox.push(table[0]);
    for(int i = 1; i < rows; i++){
        table[i-1] = table[i];
    }
    table[rows-1] = new boolean[maxLength];
  }
  
  void prevLine(){
    for(int i = rows - 2; i >= 0; i--){
      table[i+1] = table[i].clone();
    }
    if(!trashBox.empty()){
      table[0] = trashBox.pop();
    }
    else{
      for(int i = 0; i < maxLength; i++){
        table[0][i] = true;
      }
    }
    curPnt = lineEnd(rPanel.table[rPanel.targetRow]);
  }
  
  ReadPanel rPanel;
  Stack<boolean[]> trashBox;
  boolean table[][];
  int curLineEnd;
}