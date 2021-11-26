import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller66/api.dart';
import 'package:seller66/model/clients.dart';
import 'package:seller66/model/routes.dart';
import 'package:seller66/telas/products.dart';

class ClientsPage extends StatefulWidget {
  ClientsPage({required this.routeId});
  final int routeId;

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  Api api = Api();

  var imgList = [
    NetworkImage("https://img2.gratispng.com/20171209/32a/hospital-signs-5a2c23bd517e75.7493155115128421733338.jpg"),
    NetworkImage("https://thumbs.dreamstime.com/b/molde-do-logotipo-hospital-117487677.jpg"),
    NetworkImage("https://www.visiteapucarana.com.br/wp-content/uploads/2019/04/hospital.jpg"),
    NetworkImage("https://image.freepik.com/vetores-gratis/template-logo-hospital_1061-6.jpg"),
    NetworkImage("https://thumbs.dreamstime.com/b/%C3%ADcone-do-molde-dos-s%C3%ADmbolos-logotipos-hospital-111809872.jpg"),
    NetworkImage("https://i.pinimg.com/originals/7d/8b/7e/7d8b7eaff56ec97e6df928bce9bd9f3d.jpg"),
    NetworkImage("https://png.pngtree.com/element_our/20200702/ourlarge/pngtree-hospital-logo-pictures-image_2289646.jpg"),
    NetworkImage("https://image.freepik.com/vetores-gratis/template-logo-hospital_1061-6.jpg"),
    NetworkImage("https://previews.123rf.com/images/marsono/marsono1707/marsono170700651/83423958-hospital-logo-and-symbols.jpg"),
    NetworkImage("https://e7.pngegg.com/pngimages/1002/841/png-clipart-medicine-health-care-hospital-computer-icons-medical-element-trademark-logo.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7259c0),
        //centerTitle: true,
        title: Text(
          "Clientes  ",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: api.recuperarClientes(widget.routeId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List<Clients> list = snapshot.data;
                        Clients c = list[index];

                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductsPage(clientId: c.id, routeId: widget.routeId),
                              ));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Row(children: [
                                  Image(
                                    image: imgList[index],
                                    width: 40,
                                    height: 90,
                                    fit: BoxFit.contain,
                                  )
                                ]),
                              ),
                              title: Text(
                                c.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(
                                c.address,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }
}
