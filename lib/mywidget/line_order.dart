// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineOrder extends StatefulWidget {
  LineOrder({
    Key? key,
    required this.id,
    required this.userid,
    required this.username,
    required this.clientname,
    required this.prix,
    required this.date,
  }) : super(key: key);
  late var id, userid, username, clientname, prodcmdid, prix, date;
  late bool permision;

  @override
  State<LineOrder> createState() => _LineOrderState();
}

class _LineOrderState extends State<LineOrder> {
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
            widget.username,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            widget.clientname,
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            height: 30,
            width: 130,
            child: Center(
              child: Text(
                "${widget.prix} DA",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white10),
          ),
          Text(
            widget.date,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
