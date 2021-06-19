import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi app",
      home: Inicio(),
    );
  }
}

/*class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept": "Application/json"});
    var data = json.decode(response.body);
    print(data);
    /*List<Product> products = [];
    for (var p in data) {
      Product product = Product(p["ProductId"], p["Description"], p["Price"]);
      products.add(product);
    }
    print(products.length);*/
    return "satisfactorio";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi app"), //esto va salir arriba de la app
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text("Sergio"),
            ),
            Text("Progra aplicada"),
            Image.network(
                "https://scontent.fvvi1-2.fna.fbcdn.net/v/t1.6435-9/70734131_2463674070523160_8619446171284275200_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=x7HG-tWyHjkAX88d3I4&_nc_ht=scontent.fvvi1-2.fna&oh=0ca69a70211923e1a1470f48a6733ee8&oe=60D1FA2C"),
            ElevatedButton(
                child: new Text("Obteniendo datos"), onPressed: getData),
          ],
        ));
  }
}*/

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Product>> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept": "Application/json"});
    var data = json.decode(response.body);
    print(data);
    List<Product> products = [];
    for (var p in data) {
      Product product = Product(p["name"], p["email"]);
      products.add(product);
    }
    print(products.length);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sergio_app")),
        body: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando...."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int productId) {
                    return ListTile(
                      title: Text(snapshot.data[productId].name),
                      subtitle: Text(snapshot.data[productId].email),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class Product {
  final String name;
  final String email;

  Product(this.name, this.email);
}
