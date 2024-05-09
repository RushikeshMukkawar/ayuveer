import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:provider/provider.dart';

import '../providers/message_history.dart';
import './medicines_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  static String route = '/chatbot';
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late DialogFlowtter dialogFlowtter;

  @override
  void initState() {
    super.initState();
    _initSetup();
  }

  @override
  void dispose() {
    super.dispose();
    dialogFlowtter.dispose();
  }

  Future<void> _initSetup() async {
    String path = 'assets/dialog_flow_auth.json';
    dialogFlowtter = await DialogFlowtter.fromFile(
      path: path,
      sessionId: 'chalo_baatein_kare',
      projectId: 'ayuveer-9ew9',
    );
  }

  final ChatUser _currentUser = ChatUser(id: '1');
  final ChatUser _ayuveerBot = ChatUser(id: '2');
  final List<ChatUser> _typingUsers = [];

  CollectionReference Questions =
      FirebaseFirestore.instance.collection('Questions');

  bool rog_questions_start = false;
  List<String> questions = [];
  int question_idx = -1;
  String curr_rog = "";
  String show_ans = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'आयुवीर',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUsers,
          messageOptions: MessageOptions(
            currentUserContainerColor: Color(0xFFFF6E90),
            currentUserTextColor: Colors.white,
            containerColor: Color(0xFFFBAED2),
            textColor: Colors.black,
            showOtherUsersAvatar: false,
          ),
          onSend: (ChatMessage message) {
            sendMessage(message);
          },
          messages:
              Provider.of<MessageHistory>(context, listen: false).messages),
    );
  }

  void navigateWithDelay(BuildContext context, String medicine) {
    rog_questions_start = false;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, MedicinesScreen.route, arguments: medicine);
    });
  }

  void insertChatMessage(BuildContext context, String user, String text) async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _typingUsers.remove(_ayuveerBot);
        Provider.of<MessageHistory>(context, listen: false).insertMessage(
          0,
          ChatMessage(
            user: ChatUser(id: user),
            createdAt: DateTime.now(),
            text: text,
          ),
        );
      });
    });
  }

  Future<void> loadQuestions(String docName, String response) async {
    DocumentSnapshot<Object?> snapshot = await Questions.doc(docName).get();

    if (snapshot.exists) {
      Map<String, dynamic>? documentData =
          snapshot.data() as Map<String, dynamic>?;

      questions = List<String>.from(
          documentData?['questions'].map((question) => question.toString()));

      question_idx = 0;
      show_ans = response;
    }
  }

  Future<void> sendMessage(ChatMessage message) async {
    if (message.text.isNotEmpty) {
      setState(() {
        Provider.of<MessageHistory>(context, listen: false)
            .insertMessage(0, message);

        _typingUsers.add(_ayuveerBot);
      });

      if (!rog_questions_start) {
        DetectIntentResponse response = await dialogFlowtter.detectIntent(
            queryInput: QueryInput(
          text: TextInput(
            text: message.text,
          ),
        ));

        setState(
          () {
            if (response.message == null) {
              return;
            }

            String msg = response.message!.text!.text![0];

            int index = msg.indexOf('\n');
            String firstLine = "";
            if (index != -1) {
              firstLine = msg.substring(0, index);
            }

            String restOfString = msg.substring(index + 1);

            switch (firstLine) {
              case "stomachache":
                rog_questions_start = true;
                curr_rog = firstLine;
                loadQuestions('Potdukhi', restOfString).then((_) {
                  insertChatMessage(context, '2', questions[question_idx++]);
                });

                break;
              case "headache":
                rog_questions_start = true;
                curr_rog = firstLine;
                loadQuestions('Dokedukhi', restOfString).then((_) {
                  insertChatMessage(context, '2', questions[question_idx++]);
                });

                break;
              case "cough":
                rog_questions_start = true;
                curr_rog = firstLine;
                loadQuestions('Korda Khokla', restOfString).then((_) {
                  insertChatMessage(context, '2', questions[question_idx++]);
                });

                break;
              case "cold":
                rog_questions_start = true;
                curr_rog = firstLine;
                loadQuestions('Sardi Khokla', restOfString).then((_) {
                  insertChatMessage(context, '2', questions[question_idx++]);
                });
                break;
              default:
                insertChatMessage(context, '2', restOfString);
                break;
            }
          },
        );
      } else {
        if (question_idx == questions.length) {
          question_idx = 0;
          switch (curr_rog) {
            case "stomachache":
              insertChatMessage(context, '2', show_ans);
              navigateWithDelay(context, 'Potdukhi');
              break;
            case "headache":
              insertChatMessage(context, '2', show_ans);
              navigateWithDelay(context, 'Dokedukhi');
              break;
            case "cough":
              insertChatMessage(context, '2', show_ans);
              navigateWithDelay(context, 'Korda Khokla');
              break;
            case "cold":
              insertChatMessage(context, '2', show_ans);
              navigateWithDelay(context, 'Sardi Khokla');
              break;
          }
        } else {
          insertChatMessage(context, '2', questions[question_idx++]);
        }
      }
    }
  }
}
