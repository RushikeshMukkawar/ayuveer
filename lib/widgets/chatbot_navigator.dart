import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screens/chatbot_screen.dart';

class ChatbotNavigator extends StatelessWidget {
  const ChatbotNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(children: [
          SizedBox(
            height: 150,
            width: 100,
            child: Lottie.asset('assets/lottie/chatbot.json'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'तुम्हाला कसं वाटत आहे?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text("चला गप्पा मारूया."),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.pink.shade300,
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(150, 10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ChatbotScreen.route);
                },
                child: const Text(
                  'शुभस्य शीघ्रम',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
