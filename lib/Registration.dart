import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

void main() => runApp(MaterialApp());
class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirmpassword_controller     = TextEditingController();
  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Shared Preferences"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: confirmpassword_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                registerr();
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }

  void registerr() async {
    logindata = await SharedPreferences.getInstance();
    String username = username_controller.text;
    String password = password_controller.text;
    String confirmpassword  = confirmpassword_controller.text;

    if (username != '' && password != '') {
      logindata.setString('username', username);
      logindata.setString('password', password);
      logindata.setString('confirmpassword', confirmpassword);

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

    }
  }
}