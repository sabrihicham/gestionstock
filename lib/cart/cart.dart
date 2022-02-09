import 'package:destionds/myfuction/db.dart';
import 'package:destionds/myfuction/decofunction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  static String nameuser = "";
  static String iduser = "";

  List<Product> items = [];
  double price = 0.0;

  void ajoute(Product item) {
    items.add(item);
    double prix = double.parse(item.prix);
    assert(prix is double);
    price += prix;
    notifyListeners();
  }

  /*
  void exite() {
    items = [];
    price = 0;
    notifyListeners();
  }
  */
  void delete(Product item) {
    for (var i = 1; i <= item.count; i++) {
      double prix = double.parse(item.prix);
      assert(prix is double);
      price -= prix;
    }
    items.remove(item);
    notifyListeners();
  }

  int get cnt {
    return items.length;
  }

  void addcount(Product item) {
    item.count++;
    double prix = double.parse(item.prix);
    assert(prix is double);
    price += prix;
    notifyListeners();
  }

  void mincount(Product item) {
    item.count--;
    double prix = double.parse(item.prix);
    assert(prix is double);
    price -= prix;
    notifyListeners();
  }

  double get prixtotal {
    return price;
  }
}

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
      ),
      backgroundColor: const Color.fromRGBO(61, 64, 75, 800),
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "images/chakib.png",
                fit: BoxFit.cover,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.only(top: 60, right: 100, left: 100),
                child: Consumer<Cart>(builder: (context, cart, child) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cart.items.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white24),
                          child: ListTile(
                            focusColor: Colors.amberAccent,
                            title: Text(
                              cart.items[i].name,
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text("${cart.items[i].prix} DA",
                                style: const TextStyle(color: Colors.black54)),
                            leading:
                                const Icon(Icons.keyboard_arrow_right_outlined),
                            trailing: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cart.addcount(cart.items[i]);
                                      },
                                      icon: const Icon(Icons.add_box)),
                                  Text(cart.items[i].count.toString()),
                                  IconButton(
                                      onPressed: () {
                                        if (cart.items[i].count == 1) {
                                        } else {
                                          cart.mincount(cart.items[i]);
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.indeterminate_check_box)),
                                  IconButton(
                                      onPressed: () {
                                        cart.delete(cart.items[i]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ),
              Consumer<Cart>(builder: (context, cart, child) {
                return Column(
                  children: [
                    Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text("${cart.prixtotal} DA"))),
                    MaterialButton(
                        height: 50,
                        minWidth: 150,
                        disabledColor: Colors.white10,
                        onPressed: cart.cnt == 0
                            ? null
                            : () {
                                var txtname = TextEditingController();
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      'Confirmation',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: SizedBox(
                                      height: 159,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextField(
                                            decoration:
                                                txtfldstyle("Client Name"),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            controller: txtname,
                                          ),
                                          Text(
                                            "Prix Total : ${cart.price} DA",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    backgroundColor: Colors.white10,
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Cancel');
                                        },
                                        child: const Text(
                                          'CANCEL',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (txtname.text.isEmpty) {
                                            Snakebr(
                                                Colors.red,
                                                "L'erreur de champ est vide",
                                                context);
                                          } else {
                                            Navigator.pop(context, 'OK');
                                            String finder = DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toString();

                                            String gen = cmdgen(
                                                cart.items, finder.toString());
                                            gen = gen.substring(
                                                0, gen.length - 1);
                                            insertcmd(gen);
                                            addcmd(
                                                finder,
                                                Cart.iduser,
                                                Cart.nameuser,
                                                txtname.text,
                                                cart.price.toString());

                                            cart.dispose();
                                            Navigator.pop(context);
                                            Snakebr(Colors.green,
                                                "Done Successfully", context);
                                          }
                                        },
                                        child: const Text(
                                          'CONFIRMER',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                        color: Colors.white24,
                        child: Text("Checkout",
                            style: TextStyle(
                                color: cart.cnt == 0
                                    ? Colors.white10
                                    : Colors.white)))
                  ],
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
