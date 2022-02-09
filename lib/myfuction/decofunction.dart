import 'package:flutter/material.dart';


// ignore: non_constant_identifier_names
Snakebr(Color a, String txt, var b) {
  ScaffoldMessenger.of(b).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(txt),
    backgroundColor: a,
  ));
}


  InputDecoration txtfldstyle(txtf) {
    return InputDecoration(
      labelText: txtf,
      fillColor: const Color.fromRGBO(61, 64, 75, 800),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }