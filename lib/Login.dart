import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock/Home.dart';

import 'package:http/http.dart' as http;
import 'package:stock/Namewise.dart';

import 'HomeUser.dart';
import 'Model/ModelLoginApi.dart';

String erromsg = "";
List<StockLogin> modeldatavar;

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  List<StockLogin> convertedJsonDatalogin;

  Future<List<StockLogin>> fetchLoginData(String p) async {
    try {
      http.Response response =
          await http.get('http://103.87.24.57/stockapi/users/' + p);
      if (response.statusCode == 200) {
        convertedJsonDatalogin = stockLoginFromJson(response.body);
        return convertedJsonDatalogin;
      } else {
        return throw Exception('Failed to load ...');
      }
    } catch (e) {
      return throw Exception('Failed to load ...');
    }
  }

  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin2() async {
    // Showing CircularProgressIndicator.

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      var v = await fetchLoginData(email);

      if (convertedJsonDatalogin.isEmpty) {
        setState(() {
          erromsg = 'invalid user';
        });
      } else if (convertedJsonDatalogin[0].pass != password) {
        setState(() {
          erromsg = 'invalid password';
        });
      } else if (convertedJsonDatalogin[0].pass == password &&
          convertedJsonDatalogin[0].type == "U") {
        erromsg = ' ';
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeUser(
                      mob: email,
                      utype: convertedJsonDatalogin[0].type,
                      branchid: convertedJsonDatalogin[0].branchid.toString(),
                    )));
      } else if (convertedJsonDatalogin[0].pass == password &&
          convertedJsonDatalogin[0].type == "A") {
        erromsg = ' ';
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/homeBg.jpg'),
                radius: 60.0,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: emailController,
              decoration: InputDecoration(labelText: 'Enter Mobile'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Enter Password'),
              autofocus: false,
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: userLogin2,
              child: Text('login'),
            ),
            Text(erromsg),
          ],
        ),
        // ],
      ),
      // ),
    );
  }
}
