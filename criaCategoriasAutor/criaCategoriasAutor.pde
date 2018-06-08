/*
programa para criar as páginas de categorias de autor da Wiki
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
  //carrega a tabela exportada pelo csvMuseuToWiki
  table1 = loadTable("csvMuseuToWiki/data/todosProntoUTF-8.csv", "header")
  table2 = new Table();
  table2.setColumnTitles(titles);
  println("tabela ok");
  table2.setColumnCount(2);
  //remove os caracteres '[' e ']'
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  //salva a nova tabela que será exportada ao final do programa
  saveTable(table2, "data/AutorPronto-UTF-8.csv");
}

void draw() {
  //vai de linha em linha na tabela 1 e escreve os dados formatados na tabela 2
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    String autor = trim(row1.getString("Acervo[Autor]"));
    row2.setString("Titulo", "Categoria:Autor/"+autor);
    row2.setString("Free Text", "[[Categoria:Autor]]");
  }
  delay(1);
  //remove os caracteres "
  table2.removeTokens(str(char(34)));
  //salva a nova tabela com os itens formatados
  saveTable(table2, "data/AutorPronto-UTF-8.csv");
  println("tabela salva");
  noLoop();
  exit();
}
