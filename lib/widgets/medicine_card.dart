import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.yellow[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                height: 200,
                width: 200,
                image: Image.asset(
                        'assets/images/$argRogName/${snapshot.data?['$index']['Name']}.png')
                    .image,
              ),
            ),
            Text(
              '${snapshot.data?['$index']['Name']}',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Color.fromARGB(255, 204, 11, 204),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'Price: ₹${snapshot.data?['$index']['Price']}',
              style: const TextStyle(
                color: Color.fromARGB(255, 204, 11, 204),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15,),
            Text(
              'By ${snapshot.data?['$index']['Proprietorship']}',
              style: const TextStyle(
                color: Color.fromARGB(255, 204, 11, 21),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
