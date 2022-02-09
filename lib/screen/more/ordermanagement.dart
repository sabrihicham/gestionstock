import 'package:destionds/myfuction/db.dart';
import 'package:destionds/mywidget/line_order.dart';
import 'package:destionds/mywidget/lineinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderManagement extends StatefulWidget {
  const OrderManagement({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final String id;

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  "Order manager",
                  style: GoogleFonts.anton(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.normal),
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
                          "User",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Client",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Prix total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          width: 70,
                        )
                      ],
                    )),
                SizedBox(
                    width: 888,
                    height: size.height - 200,
                    child: StreamBuilder(
                      
                        stream: order("show"),
                        
                        builder:
                            (context, AsyncSnapshot<List<Order>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(

                              itemCount: ord.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  title: LineOrder(
                                    id: snapshot.data![index].id,
                                    userid: snapshot.data![index].userid,
                                    username: snapshot.data![index].username,
                                    clientname:
                                        snapshot.data![index].clientname,
                                    prix: snapshot.data![index].prixtotal,
                                    date: snapshot.data![index].date,
                                  ),
                                  children: List.generate(
                                      snapshot.data![index].order.length,
                                      (i) => LineInfo(
                                          name: snapshot
                                              .data![index].order[i].name,
                                          price: snapshot
                                              .data![index].order[i].prix,
                                          id: snapshot.data![index].order[i].id,
                                          count: "1")),
                                );
                              },
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.red,
                            ));
                          }
                          return const Text('None Orders');
                        }))
              ],
            ),
          ),
        ]));
  }
}
