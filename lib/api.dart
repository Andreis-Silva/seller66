import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:seller66/model/products.dart';
import 'dart:convert';

import 'package:seller66/model/routes.dart';
import 'package:seller66/model/clients.dart';

const URL_BASE = "http://api.dev3s.com.br:8083/";

class Api {
  Future<List<Routes>> recuperarRotas() async {
    http.Response response = await http.get(Uri.parse(URL_BASE + "routes/1"));

    var dadosJson = json.decode(response.body);

    print(dadosJson);

    print(dadosJson['data']);

    List<Routes> rotas = [];

    for (var routes in dadosJson['data']) {
      print(routes);
      Routes r = Routes(routes["id"], routes["name"]);
      rotas.add(r);
      print(routes);
    }
    print(rotas.length);
    return rotas;
  }

  Future<List<Clients>> recuperarClientes(int id) async {
    http.Response response = await http.get(Uri.parse(URL_BASE + "clients/$id"));

    var dadosJson = json.decode(response.body);

    List<Clients> clientes = [];

    for (var clients in dadosJson['data']) {
      Clients c = Clients(clients["id"], clients["name"], clients["phone"], clients["address"], clients["state"]);
      clientes.add(c);
    }
    return clientes;
  }

  Future<List<Products>> recuperarProdutos() async {
    http.Response response = await http.get(Uri.parse(URL_BASE + "products"));

    var dadosJson = json.decode(response.body);

    print(dadosJson);

    List<Products> produtos = [];

    for (var products in dadosJson['data']['rows']) {
      Products p = Products(products["id"], products["name"], products["active"], products["value"]);
      produtos.add(p);
    }
    return produtos;
  }




}
