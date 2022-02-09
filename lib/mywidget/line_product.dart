// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:destionds/cart/cart.dart';
import 'package:destionds/myfuction/db.dart';
import 'package:destionds/screen/mydashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:destionds/myfuction/decofunction.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LineProduct extends StatefulWidget {
  LineProduct(
      {Key? key,
      required this.name,
      required this.price,
      required this.id,
      required this.count})
      : super(key: key);
  late var name, price, id, count;

  late bool permision;

  @override
  State<LineProduct> createState() => _LineProductState();
}

class _LineProductState extends State<LineProduct> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    find_product(List<Product> prod, String item) {
      final index = prod.indexWhere((element) => element.id == item);
      if (index >= 0) {
        return index;
      } else{
        return -1;
        }
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(61, 64, 75, 800)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white10),
            child: Center(
              child: Text(
                widget.id,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text(
            widget.name,
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            height: 30,
            width: 90,
            child: Center(
              child: Text(
                "${widget.price} DA",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white10),
          ),
          Text(
            widget.count,
            style: const TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              // Edit product
              IconButton(
                  onPressed: MyDashboard.permision
                      ? () {
                          var txtname = TextEditingController();
                          var txtprice = TextEditingController();
                          var txtcount = TextEditingController();
                          txtname.text = widget.name;
                          txtprice.text = widget.price;
                          txtcount.text = widget.count;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Editing',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: SizedBox(
                                height: 159,
                                child: Column(
                                  children: [
                                    TextField(
                                        controller: txtname,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: txtfldstyle("Name")),
                                    TextField(
                                        controller: txtprice,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: txtfldstyle("Price")),
                                    TextField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: txtcount,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: txtfldstyle("Count")),
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.white10,
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
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
                                      Snakebr(
                                          Colors.red,
                                          "L'erreur de champ est vide",
                                          context);
                                    } else {
                                      editproduct(widget.id, txtname.text,
                                          txtprice.text, txtcount.text);
                                      Snakebr(Colors.green,
                                          "Modifié avec succès", context);
                                      Navigator.pop(context, 'OK');
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
                  icon: MyDashboard.permision
                      ? const Icon(
                          Icons.edit_outlined,
                          color: Colors.white60,
                        )
                      : const Icon(
                          Icons.block,
                        )),
              //Delete product
              IconButton(
                  onPressed: MyDashboard.permision
                      ? () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Confirmer la suppression',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.white10,
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                    deleteproduct(widget.id);
                                    Snakebr(Colors.green,
                                        "Supprimé avec succès", context);
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
                  icon: MyDashboard.permision
                      ? const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.block,
                        )),
              Consumer<Cart>(builder: (context, cart, child) {
                return IconButton(
                    onPressed: () {
                      Product item = Product(
                          id: widget.id,
                          name: widget.name,
                          prix: widget.price,
                          count: 1);

                      if (find_product(cart.items, item.id) < 0) {
                        cart.ajoute(item);
                      } else {}
                    },
                    icon: const Icon(Icons.add));
              }),
            ],
          )
        ],
      ),
    );
  }
}
