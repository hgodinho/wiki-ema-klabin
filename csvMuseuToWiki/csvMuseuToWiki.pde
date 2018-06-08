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
  table = loadTable("acervoV-Corrigida.csv"); //carrega o csv exportado do File Maker
  table2 = new Table();
  //define os cabeçalhos das tabelas
  table.setColumnTitles(titles); 
  table2.setColumnTitles(titles);
  println("titulos ok");
  println(table.getRowCount());
  //cria nova tabela para receber dados formatados
  saveTable(table2, "data/todosProntoUTF-8.csv");
}

void draw() {
  //vai de linha em linha e executa comandos de formatação para os dados importarem corretamente na wiki
  for (int i = 0; i <= table.getRowCount()-1; i ++) {
    TableRow row = table.getRow(i);
    TableRow row2 = table2.getRow(i);
    
    //pega o número de tombo da peça e escreve na coluna de imagens 
    //(a imagem precisa ter como nome o número de tombo para importar corretamente na wiki)
    if (row.getString(0).contains("M-")) {
      String imagem = row.getString(0).substring(2);
      row2.setString("Acervo[imagem]", "[[Imagem:M"+imagem+".jpg]]");
      row2.setString("Acervo[thumb]", "[[Imagem:M"+imagem+".jpg|thumb|center|250px]]");
    }
    
    //alimenta a coluna de títulos da tabela a ser exportada pelo programa com o número de tombo da tabela principal importada 
    row2.setString("Titulo", row.getString("Titulo"));

    //alimenta a coluna de Acervo[Nome] da tabela a ser exportada com os nomes das obras
    String nome = row.getString("Acervo[Nome]");
    row2.setString("Acervo[Nome]", "[["+nome+"]]");

    //verifica se as informações sobre os autores existem, se não, substitui por texto padrão.
    //alimenta a coluna de Autor com o nome dos autores das peças
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

    //verifica se as informações sobre as datas existem, se não, substitui por texto padrão.
    //alimenta a coluna de Data com a data de autoria das peças
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

    //verifica se as informações sobre as origens existem, se não, substitui por texto padrão.
    //alimenta a coluna de Origem com a origem de autoria das peças
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

    //verifica se as informações sobre os materiais existem, se não, substitui por texto padrão.
    //alimenta a coluna de Material com os materiais presentes nas peças
    if (row.getString("Acervo[Material]").isEmpty()||row.getString("Acervo[Material]").equals("?")) {
      row2.setString("Acervo[Material]", "Material desconhecido");
    } else row2.setString("Acervo[Material]", row.getString("Acervo[Material]"));

    //verifica se as informações sobre as Descrições existem, se não, substitui por texto padrão.
    //alimenta a coluna de Descrição com a descrição das peças
    if (row.getString("Acervo[Descricao]").isEmpty()||row.getString("Acervo[Descricao]").equals("?")) {
      row2.setString("Acervo[Descricao]", "Sem descrição");
    } else row2.setString("Acervo[Descricao]", row.getString("Acervo[Descricao]"));

    //verifica se as informações sobre as Dimensões existem, se não, substitui por texto padrão.
    //alimenta a coluna de Dimensão com a dimensão das peças
    if (row.getString("Acervo[Dimensoes]").isEmpty()||row.getString("Acervo[Dimensoes]").equals("?")) {
      row2.setString("Acervo[Dimensoes]", "Dimensões desconhecidas");
    } else row2.setString("Acervo[Dimensoes]", row.getString("Acervo[Dimensoes]"));

    //verifica se as informações sobre as Núcleos existem, se não, substitui por texto padrão.
    //alimenta a coluna de Núcleo com o núcleo das peças
    String nucleo = row.getString("Acervo[Nucleo]");
    String nucleoClass = null;
    if (nucleo.isEmpty()) {
      row2.setString("Acervo[Nucleo]", "[[Núcleo desconhecido]]");
      nucleoClass = "[[Categoria:Núcleo/Núcleo desconhecido]]";
    } else {
      row2.setString("Acervo[Nucleo]", "[["+nucleo+"]]");
      nucleoClass =   "[[Categoria:Núcleo/"+nucleo+"]]";
    }

    //verifica se as informações sobre as Classificações existem, se não, substitui por texto padrão.
    //alimenta a coluna de Classificação com a classificação das peças
    String classificacao = row.getString("Acervo[Classificacao]");
    String classClass = null;
    if (classificacao.isEmpty()) {
      row2.setString("Acervo[Classificacao]", "[[Classificação desconhecida]]");
      classClass = "[[Categoria:Classificação/Classificação desconhecida]]";
    } else {
      if (classificacao.contains(str(char(45)))) {  
        //substitui o Char45 (-) por Char47 (/)
        String classificado = classificacao.replaceAll(str(char(45)), str(char(47)));
        //cria uma lista e separa os itens com base no char '/'
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

    //finaliza o arquivo criando a coluna das Categorias
    row2.setString("Acervo[categorias]", "[[Categoria:Acervo por nº de tombo]]"+
      autorClass+
      origemClass+
      "[[Categoria:Data/"+dataClass+"]]"+
      nucleoClass+
      classClass);
  }

  //remove aspas das colunas char34 (")
  table2.removeTokens(str(char(34)), "Acervo[categorias]"); //funciona!!
  table2.removeTokens(str(char(34)), "Acervo[Data]"); //funciona!!
  table2.removeTokens(str(char(34)), "Acervo[Autor]"); //funciona!!

  //salva a tabela com todas as modificações, pronta para inserir na Wiki
  saveTable(table2, "data/todosProntoUTF-8.csv");
  println("salvo");
  noLoop();
  exit();
}
