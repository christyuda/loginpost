import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:apirest/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _Myhomepage createState() => _Myhomepage();
}

class _Myhomepage extends State<MyHomePage> {
  var phoneController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone_android)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 45,
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    login();
                  },
                  icon: Icon(
                    Icons.login,
                    size: 18,
                  ),
                  label: Text("LOGIN"))
            ],
          ),
        )),
      ),
    );
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && phoneController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://iteungdroid-dev.ulbi.ac.id/api/v1/login"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'phone_number': phoneController.text,
            'password': passController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token : ${body['token']}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("pastikan diisi dlu sebelum login")));
    }
  }
}
