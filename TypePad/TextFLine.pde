class TextFLine extends TextLine{
  
  TextFLine(Text parent, int startPoint, int len){
    super(parent, startPoint, len);
    // curPoint = startPoint 
  }
  
  void formLine(){
    for(int i = 0; i < len; i++){
      line[i] = text.charAt(startPnt + i);
    }
    int pnt = len - 1;
    while(line[pnt] != ' '){
      line[pnt] = '*';
      pnt--;
    }

    startPnt += pnt;
  }
  
  int getNextPoint(){
    if(text.charAt(startPnt) == ' '){
      return startPnt + 1; 
    }else{
      println("Error in grtting next", text.charAt(startPnt));
      return -1;
    }
  }
}