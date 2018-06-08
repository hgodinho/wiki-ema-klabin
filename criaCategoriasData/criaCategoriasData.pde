/*
programa para criar as páginas de categorias de data da Wiki
usa a tabela csv exportada do csvMuseuToWiki.pde
escreve a nova tabela com cada linha sendo uma página de categoria para a wiki
por hgodinho.com
*/

Table table1;
Table table2;
Table table3;
String titles[] = {
  "Titulo", "Free Text"
};


void setup() {
  //carrega a tabela exportada do csvMuseuToWiki
  table1 = loadTable("csvMuseuToWiki/data/todosProntoUTF-8.csv", "header");
  table2 = new Table();
  table2.setColumnTitles(titles);
  table3 = new Table();
  table3.setColumnTitles(titles);
  println("tabelas ok");
  //remove os caracteres '[' e ']'
  table1.removeTokens(str(char(91)));
  table1.removeTokens(str(char(93)));
  //salva as novas tabelas que serão exportadas ao final do programa
  saveTable(table2, "data/DataPronto-UTF-8.csv");
  saveTable(table3, "data/DataSubPronto-UTF-8.csv");
}

void draw() {
  //vai de linha em linha na tabela 1 e escreve os dados formatados nas tabelas 2 e 3
  for (int i=0; i<=table1.getRowCount()-1; i++) {
    TableRow row1 = table1.getRow(i);
    TableRow row2 = table2.getRow(i);
    TableRow row3 = table3.getRow(i);
    String data = row1.getString("Acervo[Data]");
    //procura pelos caracteres / e separa as strings pela /
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
  //remove os caracteres "
  table2.removeTokens(str(char(34)));
  table3.removeTokens(str(char(34)));
  //salva as novas tabelas com os itens formatados
  saveTable(table3, "data/DataSubPronto-UTF-8.csv");
  saveTable(table2, "data/DataPronto-UTF-8.csv");
  println("tabela salva");
  noLoop();
  exit();
}
