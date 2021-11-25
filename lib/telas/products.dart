import 'package:flutter/material.dart';
import 'package:seller66/api.dart';
import 'package:seller66/model/products.dart';
import 'package:seller66/searchDelegate.dart';


class ProductsPage extends StatefulWidget {

  ProductsPage(this.pesquisa);
  String pesquisa = "";

  //const products({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7259c0),
        title: Text("Listagem de produtos",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),

        actions: <Widget> [

          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String? res = await showSearch(context: context, delegate: searchDelegate());

                }
              )
        ],

      ),

      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[

            Expanded(

              child: FutureBuilder(
                future: api.recuperarProdutos(widget.pesquisa),
                builder: (BuildContext context, AsyncSnapshot snapshot){

                  if(snapshot.data == null){
                    return Center(
                        child:
                        CircularProgressIndicator()
                    );
                  }else {
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {

                        List<Products> list = snapshot.data;
                        Products p = list[index];

                        return GestureDetector(
                            onTap: (){
                              //Navigator.of(context).push();
                            },
                            child: ListTile(
                              title: Text( p.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              subtitle: Text( p.value.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),
                              ),
                            )
                        );
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
    );
  }
}