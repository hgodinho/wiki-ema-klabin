Table table1;
Table table2;
Table table3;
String titles[] = {
  "Titulo", "Free Text" 
};


void setup() {
  //table1 = loadTable("C:/Users/Divulgacao/OneDrive/Fundação/wiki/csv to wiki/csvMuseuToWiki/data/todosProntoUTF-8.csv", "header"); //WINDOWS
  table1 = loadTable("/Volumes/GODHD/Users/henriquegodinhohd/Documents/OneDrive/Fundação/wiki/csv to wiki/csvMuseuToWiki/data/todosProntoUTF-8.csv", "header"); //MAC
  table2 = new Table();
  table2.setColumnTitles(titles);  
  table3 = new Table();
  table3.setColumnTitles(titles);
  println("tabelas ok");
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  saveTable(table2, "data/DataPronto-UTF-8.csv");
  saveTable(table3, "data/DataSubPronto-UTF-8.csv");
}

void draw() {
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    TableRow row3 = table3.getRow(i);
    String data = row1.getString("Acervo[Data]");
    
    if (data.contains(str(char(47)))) {
      int data1 = data.indexOf(char(47));
      String dataUM = data.substring(0, data1);
      String dataDOIS = data.substring(data1+1);
      println(dataUM+"/"+dataDOIS);
      row2.setString("Titulo", "Categoria:Data/"+dataUM);
      row2.setString("Free Text", "[[Categoria:Data]]");
      row3.setString("Titulo", "Categoria:Data/"+dataUM+"/"+dataDOIS);
      row3.setString("Free Text", "[[Categoria:Data/"+dataUM+"]]");
    } else {
      row2.setString("Titulo", "Categoria:Data/"+data);
      row2.setString("Free Text", "[[Categoria:Data]]");
    }
  }
  delay(1);
  table2.removeTokens(str(char(34)));
  table3.removeTokens(str(char(34)));
  saveTable(table3, "data/DataSubPronto-UTF-8.csv");
  saveTable(table2, "data/DataPronto-UTF-8.csv");
  println("tabela salva");
  noLoop();
  exit();
}