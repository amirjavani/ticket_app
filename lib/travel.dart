import 'dart:ffi';

class Travel {
  late String bussID;
  late String bussKind;
  late String bussCompany;
  late String des;
  late String origin;
  late String date;
  late String time;
  late double price;
  late int totalCapacity;
  late int capacity;

  Travel(this.bussID, this.bussKind, this.bussCompany, this.des, this.origin,
      this.date, this.time, this.price, this.totalCapacity, this.capacity);
}
