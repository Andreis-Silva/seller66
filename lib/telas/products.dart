import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller66/api.dart';
import 'package:seller66/model/products.dart';
import 'package:seller66/searchDelegate.dart';

class ProductsPage extends StatefulWidget {
  final int clientId;
  final int routeId;
  ProductsPage({required this.clientId, required this.routeId});

  //const products({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Api api = Api();
  String pesquisa = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7259c0),
        title: Text(
          "Listagem de produtos",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String? res = await showSearch(context: context, delegate: searchDelegate());
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 80),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: api.recuperarProdutos(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List<Products> list = snapshot.data;

                        Products p = list[index];



                        return GestureDetector(

                            child: ListTile(
                              title: Text(
                                p.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(
                                p.value.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              trailing: GestureDetector(
                                onTap: () => quantityModal(p),
                                child: Icon(Icons.add_circle),
                              ),
                            ));
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 3,
                        color: Colors.black,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => pedidoRealizado()));
        },
        child: Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


   pedidoRealizado(){
    return Container(
       color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network("https://consorciomagalu.com.br/wp-content/uploads/2020/07/verificado-1.png",
              width: 300,
              ),
              Text("Pedido realizado",
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              )
            ],
     )
    );

  }




  void quantityModal(Products p) {
    TextEditingController controller = TextEditingController();

    //TODO: resgatar da rota invoice_items, a quantidade atual
    int count = 0;
    controller.text = count.toString();


    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Informe a quantidade'),
            content: Container(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name),
                  Text(p.value.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          count--;
                          setState(() {
                            controller.text = count.toString();
                          });
                        },
                        child: Icon(Icons.remove_circle),
                      ),

                      Container(
                        width: 110,
                        child: TextField(
                         controller: controller,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          count++;
                          setState(() {
                            controller.text = count.toString();
                          });
                          },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actionsPadding: EdgeInsets.all(0),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {

                  Navigator.of(context).pop();

                  //TODO: Chamar api para atualizar item do pedido (PUT invoice-items)
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        });
  }

}
