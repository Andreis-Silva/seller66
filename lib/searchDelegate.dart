import 'package:flutter/material.dart';


class searchDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
    );


  }

  @override
  Widget buildResults(BuildContext context) {

    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> lista = [];

    if( query.isNotEmpty ){

      lista = [
        "Seringa", "Fio", "Agulha", "Máscara", "Algodão", "Bandagem", "Pano",
        "Sonda", "Bisturi", "Cateter", "Luva", "Compressa", "Caneta", "Cânula",
        "Atadura", "Lancetas", "Tipoia", "Extensor", "Espéculo", "Esparadrapo",
        "Lâmina", "Abaixador", "Coletor", "Curativo", "Lençol", "Fita", "Sapatilha",
        "Touca", "Tubo", "Scalp", "Almotolia", "Kit", "Blood"
      ].where((texto) => texto.toLowerCase().startsWith( query.toLowerCase() )
      ).toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return ListTile(
                onTap: (){
                  close(context, lista[index]);
                },
                title: Text(lista[index])
            );
          }
      );
    }else{
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }
  }


}