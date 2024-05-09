import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import './providers/message_history.dart';
import './screens/homepage_screen.dart';
import 'screens/chatbot_screen.dart';
import './screens/medicine_detail_screen.dart';
import './screens/medicines_screen.dart';
import './screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MessageHistory(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ayu Veer',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            centerTitle: true,
          )
        ),
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          HomepageScreen.route: (context) => const HomepageScreen(),
          ChatbotScreen.route: (context) => const ChatbotScreen(),
          MedicinesScreen.route: (context) => const MedicinesScreen(),
          MedicineDetailScreen.route: (context) => const MedicineDetailScreen(),
        },
      ),
    );
  }
}
