import 'package:flutter/material.dart';

class MedicineDetailScreen extends StatefulWidget {
  const MedicineDetailScreen({super.key});

  static String route = '/medicine_detail_screen';

  @override
  State<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Detail'),
      ),
      backgroundColor: Colors.amber.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
                height: 300,
                width: 200,
                image: Image.asset(
                        'assets/images/${args['rogName']}/${args['name']}.png')
                    .image),
            TextBlock(text: args['name'] as String),
            TextBlock(text: "By: ${args['proprietorship']}"),
            TextBlock(text: 'Price: ₹${args['price']}'),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
              ),
              child: const TextBlock(text: 'Ingredients'),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
              ),
              height: 150,
              child: Scrollbar(
                thickness: 10,
                child: ListView.builder(
                  itemCount: args['ingredients'].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.arrow_right),
                      title: Text(
                        args['ingredients'][index],
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBlock extends StatelessWidget {
  final String? text;
  const TextBlock({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        text!,
        style: const TextStyle(
          color: Color.fromARGB(255, 204, 11, 101),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
