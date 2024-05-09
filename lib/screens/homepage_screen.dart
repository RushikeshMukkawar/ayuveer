import 'package:flutter/material.dart';

import '../widgets/chatbot_navigator.dart';
import '../widgets/rog_widget.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});
  static String route = '/homescreen';

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
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
            'आयुवीर',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const ChatbotNavigator(),
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                child: const Text(
                  'नमस्कार',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: const [
                    RogWidget(
                      name: 'डोकेदुखी',
                      rogName: 'Dokedukhi',
                    ),
                    RogWidget(
                      name: 'खोकला',
                      rogName: 'Korda Khokla',
                    ),
                    RogWidget(
                      name: 'सर्दी',
                      rogName: 'Sardi Khokla',
                    ),
                    RogWidget(
                      name: 'पोटदुखी',
                      rogName: 'Potdukhi',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
