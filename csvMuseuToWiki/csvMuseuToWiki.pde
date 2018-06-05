Table table;
Table table2;

String titles[] = {
  "Titulo", "Acervo[Nome]", 
  "Acervo[Autor]", "Acervo[Data]", 
  "Acervo[Origem]", "Acervo[Material]", 
  "Acervo[Descricao]", "Acervo[Dimensoes]", 
  "Acervo[Nucleo]", "Acervo[Classificacao]", "Acervo[imagem]", 
  "Acervo[thumb]", "Acervo[categorias]"
};

String dataUM = null;
String dataDOIS = null;

void setup() {
  table = loadTable("acervoV-Corrigida.csv");
  table2 = new Table();
  table.setColumnTitles(titles);
  table2.setColumnTitles(titles);
  println("titulos ok");
  println(table.getRowCount());
  saveTable(table2, "data/todosProntoUTF-8.csv");
}

void draw() {
  //vai de linha em linha e executa comandos de formatação para os dados importarem corretamente na wiki
  for (int i = 0; i <= table.getRowCount()-1; i ++) {
    TableRow row = table.getRow(i);
    TableRow row2 = table2.getRow(i);

    if (row.getString(0).contains("M-")) {
      String imagem = row.getString(0).substring(2);
      row2.setString("Acervo[imagem]", "[[Imagem:M"+imagem+".jpg]]");
      row2.setString("Acervo[thumb]", "[[Imagem:M"+imagem+".jpg|thumb|center|250px]]");
    }
    //verifica tombo
    row2.setString("Titulo", row.getString("Titulo"));

    //verifica titulo
    String nome = row.getString("Acervo[Nome]");
    row2.setString("Acervo[Nome]", "[["+nome+"]]");

    //verifica se as informações constam, se não, substitui por texto padrão.
    //verifica autores
    String autor = row.getString("Acervo[Autor]");
    String autorClass = null;
    if (autor.isEmpty()||
      autor.equals("?")) {
      row2.setString("Acervo[Autor]", "[[Autor desconhecido]]");
      autorClass = "[[Categoria:Autor/Autor desconhecido]]";
    } else {
      row2.setString("Acervo[Autor]", "[["+autor+"]]");
      autorClass = "[[Categoria:Autor/"+autor+"]]";
    }

    //verifica datas
    String data = row.getString("Acervo[Data]");
    String dataClass = null;
    if (data.isEmpty()||data.equals("?")||
      data.equals(" ?")||data.equals("? ")||
      data.equals(" ? ")||data.equals("(?)")) {
      row2.setString("Acervo[Data]", "[[Data desconhecida]]");
      dataClass = "Data desconhecida";
    } else {
      if (data.contains(str(char(44)))) {
        int data1 = data.indexOf(char(44));
        int data2 = data.indexOf(char(44), data1+1);
        int data3 = data.indexOf(char(34), data2+1);
        dataUM = data.substring(0, data1);
        dataDOIS = data.substring(data1+1);
        row2.setString("Acervo[Data]", "[["+dataUM+"]]/[["+dataDOIS+"]]");
        dataClass = dataUM+"/"+dataDOIS;
      } else {
        row2.setString("Acervo[Data]", "[["+data+"]]");
        dataClass = "Data desconhecida";
      }
    }

    //verifica origem
    String origem = row.getString("Acervo[Origem]");
    String origemClass = null;
    if (origem.isEmpty()||origem.equals("?")) {
      row2.setString("Acervo[Origem]", "[[Origem desconhecida]]");
      origemClass = "[[Categoria:Origem/Origem desconhecida]]";
    } else {
      if (origem.contains(str(char(44)))) {
        int origem1 = origem.indexOf(char(44));
        String origemUM = origem.substring(0, origem1);
        String origemDOIS = origem.substring(origem1+2);

        row2.setString("Acervo[Origem]", "[["+origemUM+"]]/[["+origemDOIS+"]]");
        origemClass = "[[Categoria:Origem/"+origemUM+"/"+origemDOIS+"]]";
      } else {
        row2.setString("Acervo[Origem]", "[["+origem+"]]");
        origemClass = "[[Categoria:Origem/"+origem+"]]";
      }
    }

    //verifica material
    if (row.getString("Acervo[Material]").isEmpty()||row.getString("Acervo[Material]").equals("?")) {
      row2.setString("Acervo[Material]", "Material desconhecido");
    } else row2.setString("Acervo[Material]", row.getString("Acervo[Material]"));

    //verifica descricao
    if (row.getString("Acervo[Descricao]").isEmpty()||row.getString("Acervo[Descricao]").equals("?")) {
      row2.setString("Acervo[Descricao]", "Sem descrição");
    } else row2.setString("Acervo[Descricao]", row.getString("Acervo[Descricao]"));

    //verifica dimensoes
    if (row.getString("Acervo[Dimensoes]").isEmpty()||row.getString("Acervo[Dimensoes]").equals("?")) {
      row2.setString("Acervo[Dimensoes]", "Dimensões desconhecidas");
    } else row2.setString("Acervo[Dimensoes]", row.getString("Acervo[Dimensoes]"));

    //verifica núcleo
    String nucleo = row.getString("Acervo[Nucleo]");
    String nucleoClass = null;
    if (nucleo.isEmpty()) {
      row2.setString("Acervo[Nucleo]", "[[Núcleo desconhecido]]");
      nucleoClass = "[[Categoria:Núcleo/Núcleo desconhecido]]";
    } else {
      row2.setString("Acervo[Nucleo]", "[["+nucleo+"]]");
      nucleoClass =   "[[Categoria:Núcleo/"+nucleo+"]]";
    }

    //verifica classificacao
    String classificacao = row.getString("Acervo[Classificacao]");
    String classClass = null;
    if (classificacao.isEmpty()) {
      row2.setString("Acervo[Classificacao]", "[[Classificação desconhecida]]");
      classClass = "[[Categoria:Classificação/Classificação desconhecida]]";
    } else {
      if (classificacao.contains(str(char(45)))) {  
        String classificado = classificacao.replaceAll(str(char(45)), str(char(47)));
        String[] list = split(classificado, char(47));
        if (list.length >= 2) {
          row2.setString("Acervo[Classificacao]", "[[Classificação]]/[["+list[0]+"]]/[["+list[1]+"]]");
          classClass = "[[Categoria:Classificação/"+list[0]+"/"+list[1]+"]]";
        }
        if (list.length >= 3) {
          row2.setString("Acervo[Classificacao]", "[[Classificação]]/[["+list[0]+"]]/[["+list[1]+"]]/[["+list[2]+"]]");
          classClass = "[[Categoria:Classificação/"+list[0]+"/"+list[1]+"/"+list[2]+"]]";
        }
        if (list.length > 4) {   
          row2.setString("Acervo[Classificacao]", "[[Classificação]]/[["+list[0]+"]]/[["+list[1]+"]]/[["+list[2]+"]]/[["+list[3]+"]]");
          classClass = "[[Categoria:Classificação/"+list[0]+"/"+list[1]+"/"+list[2]+"/"+list[3]+"]]";
        }
        trim(list);
      } else {
        row2.setString("Acervo[Classificacao]", "[[Classificação]]/[["+classificacao+"]]");
        classClass = "[[Categoria:Classificação/"+classificacao+"]]";
      }
    }

    //finaliza
    row2.setString("Acervo[categorias]", "[[Categoria:Acervo por nº de tombo]]"+
      autorClass+
      origemClass+
      "[[Categoria:Data/"+dataClass+"]]"+
      nucleoClass+
      classClass);
  }

  //remove aspas das colunas [char(34) = "]
  table2.removeTokens(str(char(34)), "Acervo[categorias]"); //funciona!!
  table2.removeTokens(str(char(34)), "Acervo[Data]"); //funciona!!
  table2.removeTokens(str(char(34)), "Acervo[Autor]"); //funciona!!

  saveTable(table2, "data/todosProntoUTF-8.csv");
  println("salvo");
  noLoop();
  exit();
}