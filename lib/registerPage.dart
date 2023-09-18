import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mogodb_project/main.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController nameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController phoneNumCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: fullNameCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'fullName',
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
                controller: emailCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email',
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
                controller: addressCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'address',
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
                controller: phoneNumCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'phone number',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await MyApp.db.open();
                  await MyApp.db.collection('users').insertOne({
                    'username': nameCon.text,
                    'fullName': fullNameCon.text,
                    'password': passCon.text,
                    'address': addressCon.text,
                    'phoneNum': phoneNumCon.text,
                    'email': emailCon.text,
                    'tickets': [],
                  });
                  await MyApp.db.close();
                  Navigator.pop(context);
                },
                child: Text('register')),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('login'))
          ],
        ),
      ),
    );
  }
}
