/*
programa para criar as páginas de redirecionamento da Wiki: nome da obra >> numero de tombo
usa uma tabela preparada contendo somente as colunas de numero de tombo e nome da obra
escreve a nova tabela com cada linha sendo uma página de categoria para a wiki
por hgodinho.com
*/

Table table;
String titles[] = {
  "Titulo", "Numero de Tombo", "Free Text"
};

void setup() {
  //carrega a tabela preparada contendo somente numero de tombo e nome da obra
  table = loadTable("todos.csv");
  table.setColumnTitles(titles);
  println("titulos ok");
  println(table.getRowCount());
  //cria a nova tabela que receberá os dados preparados
  saveTable(table, "data/redirects.csv");
}

void draw() {
  //vai de linha em linha e executa comandos de formatação para os dados importarem corretamente na wiki
  for (int i = 0; i <= table.getRowCount()-1; i ++) {
    TableRow row = table.getRow(i);
    if (row.getString(1).contains("M-")) {
      String redirect = row.getString(1);
      row.setString("Free Text", "#redirect [["+redirect+"]]"+" [[Categoria:Acervo por Título]]");
    }
  }
  table.removeColumn(1);
  //salva a nova tabela
  saveTable(table, "data/redirects.csv");
  println("salvo");
  noLoop();
  exit();
}
