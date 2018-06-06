Table table;
String titles[] = {
  "Titulo", "Numero de Tombo", "Free Text"
};

void setup() {
  table = loadTable("todos.csv");
  table.setColumnTitles(titles);
  println("titulos ok");
  println(table.getRowCount());
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
  saveTable(table, "data/redirects.csv");
  println("salvo");
  noLoop();
  exit();
}