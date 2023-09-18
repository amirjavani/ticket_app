import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mogodb_project/ticket.dart';
import 'package:mogodb_project/travel.dart';

import 'main.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController desCon = TextEditingController();
  TextEditingController originCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController codeCon = TextEditingController();

  List<Travel> travels = [];

  Future<void> gettingTravels() async {
    var db = MyApp.db;
    await db.open();
    List trvls = await db.collection('travels').find({
      'des': desCon.text,
      'origin': originCon.text,
      'date': dateCon.text
    }).toList();
    if (trvls.isNotEmpty) {
      travels = [];
      trvls.forEach((travel) {
        travels.add(Travel(
            travel['bussCode'],
            travel['bussKind'],
            travel['bussCompany'],
            travel['des'],
            travel['origin'],
            travel['date'],
            travel['time'],
            travel['price'],
            travel['totalCapacity'],
            travel['capacity']));
        print(
            'buss code: ${travel['bussCode']} - buss kind : ${travel['bussKind']} - buss company  : ${travel['bussCompany']} - price : ${travel['price']} - capacity : ${travel['capacity']} - departure time : ${travel['time']}');
      });
    }
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.userName),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: originCon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('origin'),
                      hintText: 'origin',
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: desCon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('destination'),
                      hintText: 'destination',
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                )
              ],
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
                label: Text('date'),
                hintText: 'date',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await gettingTravels();
                    setState(() {});
                  },
                  child: Text('search')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyTicket();
                        },
                      ),
                    );
                  },
                  child: Text('My tickets')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: travels.length,
              itemBuilder: (context, index) {
                var travel = travels[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'type ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: travel.bussKind,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' company '),
                                    TextSpan(
                                        text: travel.bussCompany,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      travel.origin,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.arrow_forward_sharp),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      travel.des,
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Text('move at ${travel.date} ${travel.time} '),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.chair_alt),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('${travel.capacity.toString()}  left'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('${travel.price} \$'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: travel.capacity == 0
                                          ? null
                                          : () {
                                              buy(travel.bussID);
                                            },
                                      child: Text('buy')),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> buy(var bussCode) async {
    var db = MyApp.db;
    await db.open();
    var val = await db.collection('travels').findOne({
      'bussCode': bussCode,
    });
    await db.close();
    if (val != null) {
      if (val['capacity'] > 0) {
        await decTicket(val);
        await getTicket(val);
      } else {
        print('bus is full');
      }
    } else {
      print('not found');
    }
    await gettingTravels();
    setState(() {});
  }

  Future<void> getTicket(var element) async {
    var db = MyApp.db;
    await db.open();
    await db.collection('users').updateOne({
      'username': MyApp.userName,
    }, {
      '\$push': {
        'tickets': {
          'date': element['date'],
          'chair': element['capacity'],
          'origin': element['origin'],
          'des': element['des'],
          'time': element['time'],
          'price': element['price'],
          'bussCode': element['bussCode'],
          'bussKind': element['bussKind'],
          'bussCompany': element['bussCompany'],
        }
      }
    });
    await db.close();
  }

  Future<void> decTicket(var element) async {
    var db = MyApp.db;
    await db.open();

    await db.collection('travels').updateOne({
      'bussCode': element['bussCode'],
    }, {
      '\$inc': {'capacity': -1}
    });
    await db.close();
  }
}

class MyTicket extends StatefulWidget {
  MyTicket({Key? key}) : super(key: key);

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  List<Ticket> _tickets = [];

  Future<void> gettingTickets() async {
    var db = MyApp.db;
    await db.open();
    Map? response =
        await db.collection('users').findOne({'username': MyApp.userName});
    print(response!['tickets'][0]);
    List tickets = response['tickets'];

    tickets.forEach((ticket) {
      _tickets.add(Ticket(
        ticket['bussCode'],
        ticket['chair'],
        ticket['bussKind'],
        ticket['bussCompany'],
        ticket['des'],
        ticket['origin'],
        ticket['date'],
        ticket['time'],
        ticket['price'],
      ));
    });
    await db.close();
    setState(() {});
  }

  @override
  void initState() {
    gettingTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your tickets '),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _tickets.length,
            itemBuilder: (context, index) {
              var ticket = _tickets[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'type ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ticket.bussKind,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: ' company '),
                                  TextSpan(
                                      text: ticket.bussCompany,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    ticket.origin,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward_sharp),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ticket.des,
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Text('move at ${ticket.date} ${ticket.time} '),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.chair_alt),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('${ticket.chairNum.toString()}  chair'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${ticket.price} \$'),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
