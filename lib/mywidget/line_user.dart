// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:destionds/myfuction/db.dart';
import 'package:flutter/material.dart';

import 'package:destionds/myfuction/decofunction.dart';
import 'package:crypto/crypto.dart';

bool visible = true;

// ignore: must_be_immutable
class LineUser extends StatefulWidget {
  LineUser(
      {Key? key,
      required this.id,
      required this.name,
      required this.password,
      required this.type})
      : super(key: key);
  late var id, name, password, type;
  late bool permision;

  @override
  State<LineUser> createState() => _LineUserState();
}

class _LineUserState extends State<LineUser> {
  List<String> typeitems = ["Admin", "User"];
  late String selectedtype = widget.type;
  @override
  Widget build(BuildContext context) {
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
            child: const Center(
              child: Text(
                "**********",
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white10),
          ),
          SizedBox(
            child: Row(
              children: [
                const Icon(Icons.settings, color: Colors.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.type,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Row(
            children: [
              // Edit product
              IconButton(
                  onPressed: () {
                    String dropdownValue = 'admin';
                    var txtpassword = TextEditingController();
                    var txtname = TextEditingController();
                    if (widget.type == "admin") {
                      dropdownValue = 'admin';
                    } else {
                      dropdownValue = 'user';
                    }

                    txtname.text = widget.name;
                    txtpassword.text = "";

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
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
                                      obscureText: visible ? true : false,
                                      controller: txtpassword,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          fillColor: const Color.fromRGBO(
                                              61, 64, 75, 800),
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () => setState(() {
                                              visible = visible ? false : true;
                                            }),
                                            icon: visible
                                                ? const Icon(
                                                    Icons.visibility,
                                                    color: Colors.white,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    color: Colors.white),
                                          )),
                                    ),
                                    /* TextField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: txttype,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: txtfldstyle("Type"))*/
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      borderRadius: BorderRadius.circular(10),
                                      icon: const Icon(
                                          Icons.arrow_drop_down_outlined),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      dropdownColor: Colors.white10,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'admin',
                                        'user',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
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
                                        txtpassword.text.isEmpty) {
                                      Snakebr(
                                          Colors.red,
                                          "L'erreur de champ est vide",
                                          context);
                                    } else {
                                      var pass = md5.convert(
                                          utf8.encode(txtpassword.text));
                                      edituser(widget.id, txtname.text,
                                          pass.toString(), dropdownValue);

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
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white60,
                  )),
              //Delete product
              IconButton(
                  onPressed: () {
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
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                              deleteuser(widget.id);
                              Snakebr(Colors.green, "Supprimé avec succès",
                                  context);
                            },
                            child: const Text(
                              'Oui',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
