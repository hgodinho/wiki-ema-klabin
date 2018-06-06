Table table1;
Table table2;
String titles[] = {
  "Titulo", "Free Text" 
};

void setup() {
  //println("setup inicio");
  //table1 = loadTable("C:/Users/Divulgacao/OneDrive/Fundação/wiki/csv to wiki/csvMuseuToWiki/data/todosProntoUTF-8.csv", "header"); //WINDOWS
  table1 = loadTable("/Volumes/GODHD/Users/henriquegodinhohd/Documents/OneDrive/Fundação/wiki/csv to wiki/csvMuseuToWiki/data/todosProntoUTF-8.csv", "header"); //MAC
  table2 = new Table();
  table2.setColumnTitles(titles);
  println("tabela ok");
  table2.setColumnCount(2);
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  saveTable(table2, "data/AutorPronto-UTF-8.csv");
}

void draw() {
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    String autor = trim(row1.getString("Acervo[Autor]"));
    row2.setString("Titulo", "Categoria:Autor/"+autor);
    row2.setString("Free Text", "[[Categoria:Autor]]");
  }
  delay(1);
  table2.removeTokens(str(char(34)));
  saveTable(table2, "data/AutorPronto-UTF-8.csv");
  println("tabela salva");
  noLoop();
  exit();
}