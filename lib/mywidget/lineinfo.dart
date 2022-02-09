// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class LineInfo extends StatefulWidget {
  LineInfo(
      {Key? key,
      required this.name,
      required this.price,
      required this.id,
      required this.count})
      : super(key: key);
  late var name, price, id, count;
  @override
  _LineInfoState createState() => _LineInfoState();
}

class _LineInfoState extends State<LineInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Id",
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
              Text(
                widget.id,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Name",
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
              Text(
                widget.name,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Prix",
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
              Text(
                widget.price + " Da",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Pick",
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
              Text(
                widget.count,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }
}
