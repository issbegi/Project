// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';



class ShoeModel {
  String name;
  String model;
  double price;
  String imgAddress;
  Color modelColor;
  int quantity; // Add quantity property

  ShoeModel({
    required this.name,
    required this.model,
    required this.price,
    required this.imgAddress,
    required this.modelColor,
    this.quantity = 1, // Default quantity to 1
  });
}




 
