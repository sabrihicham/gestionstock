import 'package:destionds/screen/more/ordermanagement.dart';
import 'package:destionds/screen/more/productmanagement.dart';
import 'package:destionds/screen/more/usermanagement.dart';
import 'package:destionds/screen/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Cart();
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
            routes: <String, WidgetBuilder>{
              '/UserManagement': (context) => UserManagement(
                    id: '',
                    title: '',
                  ),
              '/ProductManagement': (context) => const ProductManagement(
                    id: '',
                    title: '',
                  ),
              '/OrderHistory': (context) => const OrderManagement(
                    id: '',
                    title: '',
                  ),
            }));
  }
}
