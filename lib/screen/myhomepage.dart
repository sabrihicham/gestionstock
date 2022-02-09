import 'package:destionds/myfuction/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:destionds/myfuction/decofunction.dart';

bool show = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  static String permision = "";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var txtpassword = TextEditingController();
  var txtname = TextEditingController();
  // text field dicoration
  textfld(String txt, bool password) {
    var inputDecoration = InputDecoration(
        suffixIcon: password
            ? show
                ? IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () => setState(() => show = show ? false : true),
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility_off),
                    onPressed: () => setState(() => show = show ? false : true),
                  )
            : null,
        labelText: txt,
        fillColor: const Color.fromRGBO(61, 64, 75, 800),
        filled: true,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)));
    return inputDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        width: 400,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Sign in",
              style: GoogleFonts.lobster(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: txtname,
              style: const TextStyle(color: Colors.white),
              decoration: textfld("username", false),
            ),
            TextField(
              controller: txtpassword,
              obscureText: !show,
              style: const TextStyle(color: Colors.white),
              decoration: textfld("password", true),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                if (txtname.text.isEmpty | txtpassword.text.isEmpty) {
                  Snakebr(Colors.red, "svp entre username and pass", context);
                } else {
                  signIn(txtname.text, txtpassword.text, context);
                }
                txtname.clear();
                txtpassword.clear();
              },
              child: const Text("Login"),
              color: const Color.fromRGBO(61, 64, 75, 800),
              textColor: Colors.white,
              hoverColor: Colors.blue,
            ),
            SizedBox(
              height: 80,
            ),
            TextButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'About us',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.white10,
                      actions: <Widget>[
                        Column(
                          children: [
                            Text(
                              "Email : Sabrihicham@univ-bechar.dz",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Instagram : @Sabri.hicham               ",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: Text("About Us")),
          ],
        ),
      )),
    ]));
  }
}
