
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Registration.dart';
import 'home.dart';

void main(){
  runApp(MaterialApp(home: LoginPage(),debugShowCheckedModeBanner: false,));
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;

  late bool newuser;
  late String username;
  late String password;
  late String confirmpassword;

  @override
  void initState() {
    check_if_already_login();
    getvalue();
  }

  void getvalue() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
      password = logindata.getString('password')!;

    });
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('newuser') ?? true); // null ?? second

    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }


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
            ElevatedButton(
              onPressed: () {

                if(username !="" && password !=""){
                  if(username == username && password == password){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Username & Password is Incorrect"),
                    backgroundColor: Colors.red,));
                  }
                }
              },
              child: const Text("LOGIN"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Registration()));
                },
                child: Text("Register Here"))
          ],
        ),
      ),
    );
  }
}

