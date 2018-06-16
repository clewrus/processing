abstract class TextLine{
  TextLine(Text parent, int startPoint, int len){
    this.text = parent.text;
    this.startPnt = startPoint;
    this.len = len;
    this.line = new char[len];
    formLine();
  }
  
  abstract void formLine();
  
  StringBuilder text;
  char[] line;
  int startPnt;
  int len;
  
}