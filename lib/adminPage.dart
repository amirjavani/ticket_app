import 'package:flutter/material.dart';

import 'main.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddingTravellPage();
                    },
                  ),
                );
              },
              child: Text('add travel')),
        ],
      ),
    );
  }
}

class AddingTravellPage extends StatefulWidget {
  const AddingTravellPage({Key? key}) : super(key: key);

  @override
  State<AddingTravellPage> createState() => _AddingTravellPageState();
}

class _AddingTravellPageState extends State<AddingTravellPage> {
  TextEditingController desCon = TextEditingController();
  TextEditingController originCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController kindOfBuss = TextEditingController();
  TextEditingController bussCode = TextEditingController();
  TextEditingController companyCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController capacityCon = TextEditingController();
  TextEditingController timeCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: kindOfBuss,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'kind',
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
                  controller: bussCode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'code',
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
                  controller: companyCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'company',
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
                  controller: desCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'destination',
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
                  controller: originCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'origin',
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
                  controller: capacityCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'capacity',
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
                  controller: priceCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'price',
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
                  controller: dateCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'date',
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
                  controller: timeCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'time',
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
                    await MyApp.db.collection('travels').insertOne({
                      'bussCode': bussCode.text,
                      'bussKind': kindOfBuss.text,
                      'bussCompany': companyCon.text,
                      'des': desCon.text,
                      'origin': originCon.text,
                      'totalCapacity': int.parse(capacityCon.text),
                      'capacity': int.parse(capacityCon.text),
                      'price': double.parse(priceCon.text),
                      'date': dateCon.text,
                      'time': timeCon.text,
                    });
                    await MyApp.db.close();
                    Navigator.pop(context);
                  },
                  child: Text('add')),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('back'))
            ],
          ),
        ),
      ),
    );
  }
}
