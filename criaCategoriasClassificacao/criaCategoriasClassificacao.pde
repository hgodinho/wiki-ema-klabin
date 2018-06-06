Table table1;
Table table2;
String titles[] = {
  "Titulo", "Free Text"
};
String arquivo = "ClassificacaoPronta-UTF-8.csv";
String subarquivo = "ClassificacaoSubPronta-UTF-8.csv";

void setup() {
  //println("setup inicio");
  table1 = loadTable("csvMuseuToWiki/data/todosProntoUTF-8.csv", "header");
  table2 = new Table();
  table2.setColumnTitles(titles);
  table2.setColumnCount(2);
  saveTable(table2, "data/"+arquivo);
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  println("tabelas ok");
}
void draw() {
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);

    String classificacao = trim(row1.getString("Acervo[Classificacao]"));
    if (classificacao.contains(str(char(47)))) {
      String[] list = split(classificacao, char(47));
      trim(list);
      if (list.length >= 2) {
        row2.setString("Titulo", "Categoria:Classificação/"+list[0]+"/"+list[1]);
        row2.setString("Free Text", "[[Categoria:Classificação/"+list[0]+"]]");
      }
      if (list.length >= 3) {
        row2.setString("Titulo", "Categoria:Classificação/"+list[0]+"/"+list[1]+"/"+list[2]);
        row2.setString("Free Text", "[[Categoria:Classificação/"+list[0]+"/"+list[1]+"]]");
      }
      if (list.length > 4) {
        println("listalonga"+list.length);
        row2.setString("Titulo", "Categoria:Classificação/"+list[0]+"/"+list[1]+"/"+list[2]+"/"+list[3]);
        row2.setString("Free Text", "[[Categoria:Classificação/"+list[0]+"/"+list[1]+"/"+list[2]+"]]");
      }
    } else {
      row2.setString("Titulo", "Categoria:Classificação/Classificação desconhecida");
      row2.setString("Free Text", "[[Categoria:Classificação]]");
    }

    delay(1);
  }

  table2.removeTokens(str(char(34)));
  saveTable(table2, "data/"+arquivo);
  println("tabela salva");
  noLoop();
  exit();
}
