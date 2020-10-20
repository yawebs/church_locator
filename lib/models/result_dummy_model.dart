import 'package:flutter/material.dart';
class ResultModel {
  final String id;
  final String churchName;
  final String address;
  final String location;
  final String lga;
  final String image;

  ResultModel(
      {this.id, this.churchName, this.address, this.location, this.lga, this.image});
}

List<ResultModel> churches = [
  ResultModel(
    id: 'ch1',
    churchName: 'Salvation Ministries',
    address: '28 Afikpo Street Rumuomasi, Portharcourd',
    location: 'Portharcourt',
    lga: 'Obio-Akpor',
    image: "assets/images/smhos.jpg",
    
  ),

   ResultModel(
    id: 'ch2',
    churchName: 'Christ Embassy',
    address: '20 Garigari Kanu',
    location: 'Kanu',
    lga: 'Obio-Akpor',
    image: "assets/images/ce.png"
    
  )
];
