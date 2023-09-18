import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mogodb_project/adminPage.dart';
import 'package:mogodb_project/main.dart';
import 'package:mogodb_project/registerPage.dart';
import 'package:mogodb_project/userPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var users = <String, Map>{};

  TextEditingController nameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: nameCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'userName',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: passCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var db = MyApp.db;
                  await db.open();
                  await db.collection('users').find().forEach((element) {
                    if (element['username'] == nameCon.text &&
                        element['password'] == passCon.text) {
                      MyApp.userName = element['username'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserPage();
                          },
                        ),
                      );
                      print('success login');
                    } else {
                      print('login failed');
                    }
                  });
                  await db.close();
                },
                child: Text('login')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if ('admin' == nameCon.text && 'admin' == passCon.text) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AdminPage();
                        },
                      ),
                    );
                  } else {
                    print('wrong');
                  }
                },
                child: Text('admin login')),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      },
                    ),
                  );
                },
                child: Text('register now'))
          ],
        ),
      ),
    );
  }
}
