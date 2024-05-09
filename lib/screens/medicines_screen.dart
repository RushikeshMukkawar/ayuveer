import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/medicine_card.dart';

import './shimmer_container.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  static String route = './medicines_screen';

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  CollectionReference Aajar = FirebaseFirestore.instance.collection('Aajar');

  @override
  Widget build(BuildContext context) {
    String argRogName = ModalRoute.of(context)?.settings.arguments as String;

    return FutureBuilder(
        future: Aajar.doc(argRogName).get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.45,
                  image: AssetImage('assets/images/bg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'औषधे',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return const LoadingShimmer();
                  },
                  itemCount: 8,
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.45,
                  image: AssetImage('assets/images/bg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'औषधे',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return MedicineCard(
                      argRogName: argRogName,
                      snapshot: snapshot,
                      index: index,
                    );
                  },
                  itemCount: 9,
                ),
              ),
            );
          }
          return const Center();
        });
  }
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ShimmerContainer(
            height: 180,
            width: 150,
          ),
          SizedBox(
            height: 15,
          ),
          ShimmerContainer(height: 25, width: double.infinity),
          SizedBox(
            height: 10,
          ),
          ShimmerContainer(height: 20, width: 50),
          SizedBox(
            height: 10,
          ),
          ShimmerContainer(height: 15, width: 50),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class MedicineCardTry extends StatelessWidget {
  const MedicineCardTry({
    super.key,
    required this.argRogName,
    required this.snapshot,
    required this.index,
  });

  final String argRogName;
  final AsyncSnapshot<dynamic> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/medicine_detail_screen', arguments: {
          'rogName': argRogName,
          'name': snapshot.data?['$index']['Name'],
          'price': snapshot.data?['$index']['Price'],
          'proprietorship': snapshot.data?['$index']['Proprietorship'],
          'ingredients': snapshot.data?['$index']['Ingredients'],
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 30,
          left: 20,
          right: 20,
        ),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Text(
                '${snapshot.data?['$index']['Name']}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 204, 11, 204),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Image(
                height: 200,
                width: 200,
                image: Image.asset(
                        'assets/images/$argRogName/${snapshot.data?['$index']['Name']}.png')
                    .image),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 0,
                left: 20,
                right: 20,
              ),
              child: Text(
                'Price: ₹${snapshot.data?['$index']['Price']}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 204, 11, 204),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 0,
                left: 20,
                right: 20,
              ),
              child: Text(
                'By ${snapshot.data?['$index']['Proprietorship']}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 204, 11, 21),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
