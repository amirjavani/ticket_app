import 'dart:ffi';

class Ticket {
  late String bussID;
  late int chairNum;
  late String bussKind;
  late String bussCompany;
  late String des;
  late String origin;
  late String date;
  late String time;
  late double price;

  Ticket(this.bussID, this.chairNum, this.bussKind, this.bussCompany, this.des,
      this.origin, this.date, this.time, this.price);
}
