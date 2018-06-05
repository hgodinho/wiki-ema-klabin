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
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  table2.setColumnCount(2);
  saveTable(table2, "data/NucleoPronto.csv");

  println("tabela ok");
}

void draw() {
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    String nucleo = row1.getString("Acervo[Nucleo]");
    row2.setString("Titulo", "Categoria:Núcleo/"+nucleo);
    row2.setString("Free Text", "[[Categoria:Núcleo]]");
  }
  delay(1);
  table2.removeTokens(str(char(34)));
  saveTable(table2, "data/NucleoPronto-UTF-8.csv");
  println("tabela salva");
  println("lista salva");
  noLoop();
  exit();
}