// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:destionds/cart/cart.dart';
import 'package:destionds/screen/more/usermanagement.dart';
import 'package:destionds/screen/mydashboard.dart';
import 'package:destionds/screen/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:destionds/screen/more/productmanagement.dart';
import 'package:destionds/myfuction/decofunction.dart';
import 'package:crypto/crypto.dart';




//SIGN_IN DB
Future<String?> signIn(String _user, String _pass, var _context) async {
  final respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/signin.php?username=" +
          _user +
          "&&password=" +
          md5.convert(utf8.encode(_pass)).toString()));
  List<dynamic> user = jsonDecode(respons.body);
  if (respons.statusCode == 200) {
    print("Success");
  } else {
    print("Faild");
  }
  if (user.isEmpty) {
    Snakebr(const Color.fromARGB(100, 246, 9, 1), "login faild", _context);
  } else {
    print('login Success');
    // Run Snack bare
    Snakebr(const Color.fromARGB(100, 12, 255, 71), "login Success", _context);

    String a = user[0]['id'];
    Cart.iduser = a;
    Cart.nameuser = user[0]['name'];
    print(Cart.nameuser);
    if (user[0]['type'] == "admin") {
      // Admin Screen

      Navigator.of(_context).push(MaterialPageRoute(
          builder: (context) => MyDashboard(
                title: "admin",
                id: a,
              )));
      MyHomePage.permision = "admin";
    } else {
      Navigator.of(_context).push(MaterialPageRoute(
          builder: (context) => MyDashboard(
                title: "user",
                id: a,
              )));
      MyHomePage.permision = "user";
    }
    return user[0]['id'];
  }

}
////////////////////////////////////////////////

//Product DB

List<Product> prod = [];

class Product {
  var id, name, count, prix;

  Product(
      {required this.id,
      required this.name,
      required this.prix,
      this.count = "count"});
}

//SHOW PRODUCT
Stream<List<Product>> product(String _cmd) async* {
  while (true) {
    var respons = await http.get(Uri.parse(
        "https://a7b5-40-76-64-33.ngrok.io/product.php?cmd=" +
            _cmd +
            "&&search=" +
            ProductManagement.search.toString()));
    var user = jsonDecode(respons.body.toString());
    // ignore: duplicate_ignore
    if (respons.statusCode == 200) {
    } else {
      print('faild');
    }

    prod = [];
    for (Map i in user) {
      Product prd = Product(
          id: i['id'], name: i['name'], prix: i['prix'], count: i['count']);
      prod.add(prd);
    }
    yield prod;
  }
}

//DELETE PRODUCT
deleteproduct(String _id) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/product.php?cmd=delete&&id=" + _id));
}

// INSERT PRODUCT
insertproduct(String _name, String _price, String _count) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/product.php?cmd=insert&&name=" +
          _name +
          "&&prix=" +
          _price +
          "&&count=" +
          _count));
}

//EDIT PRODUCT
editproduct(String _id, String _name, String _price, String _count) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/product.php?cmd=edit&&id=" +
          _id +
          "&&name=" +
          _name +
          "&&prix=" +
          _price +
          "&&count=" +
          _count));
}

///////////////////////////////////////////////
// USER DB

class User {
  var id, name, password, type;
  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.type});
}

List<User> usser = [];
// SHOW USER
Stream<List<User>> user(String _cmd) async* {
  while (true) {
    // print(ProductManagement.search);
    var respons = await http.get(Uri.parse(
        "https://a7b5-40-76-64-33.ngrok.io/user.php?cmd=" +
            _cmd +
            "&&search=" +
            UserManagement.search.toString()));
    var user = jsonDecode(respons.body.toString());
    // ignore: duplicate_ignore
    if (respons.statusCode == 200) {
      // print("Success");
    } else {
      print('faild');
    }

    usser = [];
    for (Map i in user) {
      User user = User(
          id: i['id'],
          name: i['name'],
          password: i['password'],
          type: i['type']);
      usser.add(user);
    }
    yield usser;
  }
}

//DELETE USER
deleteuser(String _id) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/user.php?cmd=delete&&id=" + _id));
}

// ADD USER
insertuser(String _name, String _password, String _type) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/user.php?cmd=insert&&name=" +
          _name +
          "&&password=" +
          _password +
          "&&type=" +
          _type));
}

//DELET USER
edituser(String _id, String _name, String _password, String _type) async {
  // ignore: unused_local_variable
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/user.php?cmd=edit&&id=" +
          _id +
          "&&name=" +
          _name +
          "&&password=" +
          _password +
          "&&type=" +
          _type));
  print(respons.body);
}

//// Oder DB

class Order {
  var id, order, userid, username, finder, clientname, prixtotal, date;
  Order({
    required this.id,
    required this.finder,
    required this.order,
    required this.userid,
    required this.username,
    required this.clientname,
    required this.prixtotal,
    required this.date,
  });
}

//SHOW Order
List<Order> ord = [];
Stream<List<Order>> order(String _cmd) async* {
  while (true) {
    var respons = await http.get(Uri.parse(
        "https://a7b5-40-76-64-33.ngrok.io/order.php?cmd=" +
            _cmd +
            "&&search="));

    var order = jsonDecode(respons.body.toString());
    print(order);
    // ignore: duplicate_ignore
    if (respons.statusCode == 200) {
    } else {
      print('faild');
    }
    ord = [];
    for (Map i in order) {
      List<Product> products = await d(i['finder']);
      print(i['id']);
      print(i['finder']);
      print(i['user_id']);
      print(i['user_name']);
      print(i['client_name']);
      print(i['prix_total']);
      print(i['id']);

      Order orrd = Order(
        id: i['id'],
        finder: i['finder'],
        userid: i['user_id'],
        username: i['user_name'],
        clientname: i['client_name'],
        prixtotal: i['prix_total'],
        date: i['date'],
        order: products,
      );
      ord.add(orrd);
      print("hnaaaaa ${i['finder']}");
    }
    yield ord;
  }
}



class PrdCmd {
  var id, productid, commandeid;

  PrdCmd({
    required this.id,
    required this.productid,
    required this.commandeid,
  });
}

List<PrdCmd> ordcmd = [];

Future<List<Product>> d(String _finder) async {
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/order.php?cmd=info&&finder=" +
          _finder));
  var user = jsonDecode(respons.body.toString());
  // ignore: duplicate_ignore
  if (respons.statusCode == 200) {
  } else {
    print('faild');
  }
  prod = [];
  print(user);
  for (Map i in user) {
    Product prd = Product(id: i['id'], name: i['name'], prix: i['prix']);
    prod.add(prd);
  }
  return prod;
}


//INSERT COMMONDE

insertcmd(String _item) async {
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/order.php?cmd=insert&&prodlist=" +
          _item));
  print(respons.body);
}

addcmd(String _finder,_userid, _username, _clientname, _prixtotal) async {
  var respons = await http.get(Uri.parse(
      "https://a7b5-40-76-64-33.ngrok.io/order.php?cmd=insertcmd&&finder=" +
          _finder +
          "&&user_id=" +
          _userid +
          "&&user_name=" +
          _username +
          "&&client_name=" +
          _clientname +
          "&&prix_total=" +
          _prixtotal));
  print(respons.body);
}

String cmdgen(List<Product> items, String finder) {
  String prodlist = "";
  for (final i in items) {
    prodlist += "('" + i.id + "','" + finder + "'),";
  }
  return prodlist;
}
