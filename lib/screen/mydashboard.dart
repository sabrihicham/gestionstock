import 'package:destionds/mywidget/menudashboard.dart';
import 'package:destionds/screen/myhomepage.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key, required this.title, required this.id})
      : super(key: key);
   final String title;
   final String id;
  static late bool permision;
  static  bool show = true;
  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _MyDashboardState extends State<MyDashboard> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    if (MyHomePage.permision == "admin") {
      MyDashboard.permision = true;
    } else {
      MyDashboard.permision = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: PopupMenuButton<WhyFarther>(
              onSelected: (WhyFarther result) {
                Navigator.pop(context);
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<WhyFarther>>[
                PopupMenuItem<WhyFarther>(
                  value: WhyFarther.harder,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      Text("logout")
                    ],
                  ),
                ),
              ],
            )),
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
            child: SizedBox(
                width: 900,
                height: 500,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.0,
                  ),
                  children: [
                    MenuDashboard(
                      icon: Icons.group_add_outlined,
                      txt: "User management",
                      scr: "/UserManagement",
                      btnact: MyDashboard.permision,
                    ),
                    MenuDashboard(
                      icon: Icons.add_circle_outline,
                      txt: "Product management",
                      scr: "/ProductManagement",
                    ),
                    MenuDashboard(
                      icon: Icons.restore_outlined,
                      txt: "Order history",
                      scr: "/OrderHistory",
                    ),
                  ],
                )),
          ),
        ]));
  }
}
