import java.io.FileReader;
import java.io.FileNotFoundException;

class Text{
  
  Text(String pathName, String fileName){
    this.pathName = pathName;
    this.fileName = fileName;
    try{
      loadText(pathName, fileName);
    }catch(Exception e){
      println("Text loading Error");
      println(e);
    }
  }
  
  void loadText(String pathName, String fileName)throws FileNotFoundException, IOException{
    text = new StringBuilder();
    File f = new File(pathName, fileName);
    BufferedReader read = new BufferedReader(new FileReader(f));
    String row;
    while((row = read.readLine()) != null){
      text.append(row);
      if(row.length() == 0) continue;
      text.append(' ');
    }
    read.close();
  }
  
  String pathName;
  String fileName;
  StringBuilder text;
}