// ignore_for_file: unused_local_variable

import 'package:destionds/cart/cart.dart';
import 'package:destionds/myfuction/db.dart';
import 'package:destionds/myfuction/decofunction.dart';
import 'package:destionds/mywidget/line_product.dart';
import 'package:destionds/screen/mydashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final String id;
  static var search = "";
  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

var txtname = TextEditingController();
var txtprice = TextEditingController();
var txtcount = TextEditingController();

class _ProductManagementState extends State<ProductManagement> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

    return  Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white10,
              onPressed: MyDashboard.permision
                  ? () {
                      late String name, count, price;
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Add Product',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: SizedBox(
                            height: 159,
                            child: Column(
                              children: [
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: txtfldstyle("name"),
                                  controller: txtname,
                                ),
                                TextField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: txtfldstyle("Price"),
                                    controller: txtprice,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                                TextField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: txtfldstyle("Count"),
                                    controller: txtcount,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white10,
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                                txtname.text = "";
                                txtprice.text = "";
                                txtcount.text = "";
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (txtname.text.isEmpty |
                                    txtprice.text.isEmpty |
                                    txtcount.text.isEmpty) {
                                  Snakebr(Colors.red,
                                      "L'erreur de champ est vide", context);
                                } else {
                                  Navigator.pop(context, 'OK');
                                  insertproduct(txtname.text, txtprice.text,
                                      txtcount.text);
                                  Snakebr(Colors.green, "Ajouté avec succès",
                                      context);
                                  txtname.text = "";
                                  txtprice.text = "";
                                  txtcount.text = "";
                                }
                              },
                              child: const Text(
                                'Oui',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              child: MyDashboard.permision
                  ? const Icon(Icons.add)
                  : const Icon(Icons.block),
            ),
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white10,
              actions: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyCart()),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart_outlined)),
                    Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Consumer<Cart>(builder: (context, cart, child) {
                          return Text("${cart.items.length}");
                        })),
                  ],
                )
              ],
            ),
            backgroundColor: const Color.fromRGBO(61, 64, 75, 800),
            body: Stack(children: [
              SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    "images/chakib.png",
                    fit: BoxFit.cover,
                  )),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Product manager",
                      style: GoogleFonts.anton(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.normal),
                    ),
                    Center(
                      child: SizedBox(
                        width: 190,
                        child: TextField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white24,
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: 25,
                              ),
                              filled: true,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          onChanged: (value) {
                            setState(() {
                              ProductManagement.search = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white24),
                        height: 60,
                        width: 888,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "ID",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Nom",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Prix",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Count",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        )),
                    SizedBox(
                        width: 888,
                        height:size.height - 250,
                        child: StreamBuilder(
                          stream: product("show"),
                          builder:
                              (context, AsyncSnapshot<List<Product>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: prod.length,
                                itemBuilder: (context, index) {
                                  return LineProduct(
                                      id: snapshot.data![index].id,
                                      name: snapshot.data![index].name,
                                      price: snapshot.data![index].prix,
                                      count: snapshot.data![index].count);
                                },
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.blue,
                              ));
                            }
                          },
                        )),
                  ],
                ),
              ),
            ]));
  }
}
