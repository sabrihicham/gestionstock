// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:destionds/myfuction/db.dart';
import 'package:destionds/myfuction/decofunction.dart';
import 'package:destionds/mywidget/line_user.dart';
import 'package:destionds/screen/mydashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';

// ignore: must_be_immutable
class UserManagement extends StatefulWidget {
  UserManagement({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final String id;
  static var search = "";
  bool visible = true;
  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white10,
          onPressed: MyDashboard.permision
              ? () {
                  var txtpassword = TextEditingController();
                  var txtname = TextEditingController();
                  String dropdownValue = 'admin';
                  txtpassword.text = "";
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text(
                              'Add user',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: SizedBox(
                              height: 159,
                              child: Column(
                                children: [
                                  TextField(
                                      controller: txtname,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: txtfldstyle("Name")),
                                  TextField(
                                    obscureText: visible ? true : false,
                                    controller: txtpassword,
                                    style: const TextStyle(color: Colors.white),
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
                                              : const Icon(Icons.visibility_off,
                                                  color: Colors.white),
                                        )),
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    borderRadius: BorderRadius.circular(10),
                                    icon: const Icon(
                                        Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.white),
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
                                    Snakebr(Colors.red,
                                        "L'erreur de champ est vide", context);
                                  } else {
                                    var pass = md5
                                        .convert(utf8.encode(txtpassword.text));
                                    insertuser(txtname.text, pass.toString(),
                                        dropdownValue.toString());
                                    Snakebr(Colors.green, "Modifié avec succès",
                                        context);
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
                }
              : null,
          child: MyDashboard.permision
              ? const Icon(Icons.add)
              : const Icon(Icons.block),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
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
                  "User manager",
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
                          UserManagement.search = value;
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Type",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                        )
                      ],
                    )),
                SizedBox(
                    width: 888,
                    height: 300,
                    child: StreamBuilder(
                      stream: user("show"),
                      builder: (context, AsyncSnapshot<List<User>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: usser.length,
                            itemBuilder: (context, index) {
                              return LineUser(
                                id: snapshot.data![index].id,
                                name: snapshot.data![index].name,
                                password: snapshot.data![index].password,
                                type: snapshot.data![index].type,
                              );
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
