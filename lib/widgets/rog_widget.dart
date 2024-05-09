import 'package:flutter/material.dart';

import '../screens/medicines_screen.dart';

class RogWidget extends StatelessWidget {
  final String name;
  final String rogName;
  const RogWidget({
    required this.rogName,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MedicinesScreen.route, arguments: rogName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
          color: Colors.pink.shade300,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/cool_images/$rogName.png',
              height: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
