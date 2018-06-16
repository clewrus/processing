class TextBLine extends TextLine{
  
  TextBLine(Text parent, int startPoint, int len){
    super(parent, startPoint, len);
  }
  
  void formLine(){
    //println("--------------------------------------------------");
    if(text.charAt(startPnt) != ' ' && startPnt != 0){
      println("Initialising TaxtBLine Error");
    }
    str = new char[len + 1];
    for(int i = str.length - 1; i >= 0; i--){
      if(startPnt < 0){
        str[i] = '*';
        continue;
      }
      str[i] = text.charAt(startPnt--);
    }
    startPnt ++;
    if(str[0] != ' ' && startPnt > 0){
      if(str[0] != text.charAt(startPnt)) println("Problem");
      
      int i = 0;
      while(str[i] != ' '){
        str[i] = '*';
        i++;
        startPnt++;
      }
      str[i] = '*';
      //printArray(str);
    }
    
    for(int j = 1; j <= line.length; j++){
      line[line.length - j] = str[str.length - j];
    }
    //printArray(line);
    delStrtStars();
  }
  
  void delStrtStars(){
    if(line[len - 1] == '*') return;
    while(line[0] == '*'){   
      for(int i = 1; i < len; i++){
        line[i-1] = line[i];
      }
      line[len - 1] = '*';
    }
  }
  
  int getPrevPoint(){
    if(startPnt < 0) return 0;
    if(text.charAt(startPnt) == ' ' || startPnt == 0){
      return startPnt; 
    }else{
      println("Error in getting previus", text.charAt(startPnt), startPnt);
      return -1;
    }
  }
  
  char[] str;
}