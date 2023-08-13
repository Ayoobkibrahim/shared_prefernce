import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefernce/screen.dart';



void main(){
  runApp(MaterialApp(home: MyLoginPage(),debugShowCheckedModeBanner: false,));
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();


  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('newuser') ?? true);  // null ?? second
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDashboard()));
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
                String username = username_controller.text;
                String password = password_controller.text;


                if (username != '' && password != '') {
                  print('Successfull');

                  logindata.setBool('newuser', false);
                  logindata.setString('username', username);
                  logindata.setString('password', password);


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyDashboard()));
                }
              },
              child: const Text("LOGIN"),
            )
          ],
        ),
      ),
    );
  }
}