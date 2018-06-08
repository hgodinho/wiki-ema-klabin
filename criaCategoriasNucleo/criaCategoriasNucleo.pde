/*
programa para criar as páginas de categorias de núcleo da Wiki
usa a tabela csv exportada do csvMuseuToWiki.pde
escreve a nova tabela com cada linha sendo uma página de categoria para a wiki
por hgodinho.com
*/

Table table1;
Table table2;
String titles[] = {
  "Titulo", "Free Text"
};

void setup() {
  //println("setup inicio");
  //carrega a tabela exportada do csvMuseuToWiki
  table1 = loadTable("csvMuseuToWiki/data/todosProntoUTF-8.csv", "header");
  table2 = new Table();
  table2.setColumnTitles(titles);
  //remove os caracteres '[' e ']'
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  table2.setColumnCount(2);
  //salva as novas tabelas que serão exportadas ao final do programa
  saveTable(table2, "data/NucleoPronto.csv");

  println("tabela ok");
}

void draw() {
  //vai de linha em linha na tabela 1 e escreve os dados formatados na tabela 2
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    String nucleo = row1.getString("Acervo[Nucleo]");
    row2.setString("Titulo", "Categoria:Núcleo/"+nucleo);
    row2.setString("Free Text", "[[Categoria:Núcleo]]");
  }
  delay(1);
  //remove os caracteres "
  table2.removeTokens(str(char(34)));
  //salva a nova tabela com os itens formatados
  saveTable(table2, "data/NucleoPronto-UTF-8.csv");
  println("tabela salva");
  println("lista salva");
  noLoop();
  exit();
}
