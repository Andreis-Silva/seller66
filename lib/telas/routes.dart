import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seller66/api.dart';
import 'package:seller66/model/routes.dart';
import 'package:seller66/telas/clients.dart';


class RoutesPage extends StatefulWidget {
  //const routesPage({Key? key}) : super(key: key);

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {

    Api api = Api();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7259c0),
        //centerTitle: true,
        title: Text("Home",
          style: TextStyle(
           fontSize: 22,
           fontWeight: FontWeight.bold
      ),
      ),
      ),

      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[

            Expanded(

              child: FutureBuilder(
                future: api.recuperarRotas(),
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

                        List<Routes> list = snapshot.data;
                        Routes r = list[index];


                        return GestureDetector(
                          onTap: (){
                           Navigator.of(context).push(
                             MaterialPageRoute(
                                 builder: (context) => ClientsPage(routeId: r.id)));
                          },

                          child: ListTile(
                            title: Text( r.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
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
