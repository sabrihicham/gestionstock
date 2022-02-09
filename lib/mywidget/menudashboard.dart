import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuDashboard extends StatelessWidget {
  MenuDashboard(
      {Key? key,
      required this.txt,
      required this.icon,
      required this.scr,
      this.btnact = true})
      : super(key: key);
  late String txt, scr;
  bool btnact;
  var icon = Icons.ten_mp;

  @override
  Widget build(BuildContext context) {
    switchscreen(String scr) {
      Navigator.pushNamed(context, scr);
    }

    return MaterialButton(
      color: Colors.white10,
      hoverColor: Colors.white10,
      disabledColor: Colors.black12,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      onPressed: btnact
          ? () {
              switchscreen(scr);
            }
          : null,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(
          icon,
          size: 50,
          color: btnact ? Colors.white : Colors.white10,
        ),
        Text(
          txt,
          style: TextStyle(
              fontSize: 20, color: btnact ? Colors.white : Colors.white10),
        ),
      ]),
    );
  }
}
