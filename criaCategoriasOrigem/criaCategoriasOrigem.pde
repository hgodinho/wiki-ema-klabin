Table table1;
Table table2;
Table table3;
String titles[] = {
  "Titulo", "Free Text"
};


void setup() {
  table1 = loadTable("csvMuseuToWiki/data/todosProntoUTF-8.csv", "header");
  table2 = new Table();
  table2.setColumnTitles(titles);
  table3 = new Table();
  table3.setColumnTitles(titles);
  println("tabelas ok");
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  saveTable(table2, "data/OrigemPronto-UTF-8.csv");
  saveTable(table3, "data/OrigemSubPronto-UTF-8.csv");
}

void draw() {
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    TableRow row3 = table3.getRow(i);
    String origem = row1.getString("Acervo[Origem]");

    if (origem.contains(str(char(47)))) {
      int origem1 = origem.indexOf(char(47));
      String origemUM = origem.substring(0, origem1);
      String origemDOIS = origem.substring(origem1+1);
      println(origemUM+"/"+origemDOIS);
      row2.setString("Titulo", "Categoria:Origem/"+origemUM);
      row2.setString("Free Text", "[[Categoria:Origem]]");
      row3.setString("Titulo", "Categoria:Origem/"+origemUM+"/"+origemDOIS);
      row3.setString("Free Text", "[[Categoria:Origem/"+origemUM+"]]");
    } else {
      row2.setString("Titulo", "Categoria:Origem/"+origem);
      row2.setString("Free Text", "[[Categoria:Origem]]");
    }
  }
  delay(1);
  table2.removeTokens(str(char(34)));
  table3.removeTokens(str(char(34)));
  saveTable(table3, "data/OrigemSubPronto-UTF-8.csv");
  saveTable(table2, "data/OrigemPronto-UTF-8.csv");
  println("tabela salva");
  noLoop();
  exit();
}
