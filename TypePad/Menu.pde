abstract class Menu{
  Menu(int maxLength, int rows){
    this.maxLength = maxLength;
    this.rows = rows;
  }
  
  int lineEnd(char[] c){
    for(int i = c.length-1; i >= 0; i--){
      if(c[i] != '*')return i;
    }
    return 0;
  }
  
  char[] subSequence(char[] c, int from, int to){
    int size = to - from + 1;
    char[] seq = new char[size];
    for(int i = 0; i < size; i++){
      seq[i] = c[from + i + 1];
    }
    return seq;
  }
  
  boolean isAddKey(char c){
    if(Character.isLetter(c)) return true;
    char[] comas = {',', '.', ';', ':', '?', '"', '!', '$', '(', ')', '-', '=', '>', '<', '\'', ' ', '/'};
    for(int i = 0; i < comas.length; i++){
      if(c == comas[i]) return true;
    }
    
    char[] numbers = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
    for(int i = 0; i < numbers.length; i++){
      if(c == numbers[i]) return true;
    }
    return false;
  }
  
  abstract void prevLine();
  
  void symDelete(){
    if(textPnt == 0) return;
    curPnt--;
    textPnt--;
    if(curPnt < 0 && textPnt != 0){
      prevLine();
    }
  }
  
  Text text;
  int curPnt;
  int textPnt;
  int maxLength;
  int rows;
}