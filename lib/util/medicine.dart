import 'package:flutter/material.dart';

class Medicine {
  final String medicineName;
  final Image medicineImage;
  final String company;
  final String price;

  Medicine({
    required this.medicineName,
    required this.medicineImage,
    required this.company,
    required this.price
  });
}
