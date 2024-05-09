import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class MessageHistory extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
        user: ChatUser(id: '2'),
        createdAt: DateTime.now(),
        text: """🌱 आयुवीर वर तुमचे स्वागत आहे. 🌱
मी तुम्हाला माझ्या आयुर्वेदिक ज्ञानात मदत करेन.
तर कृपया मला सांगा की मी तुम्हाला कशी मदत करू शकतो"""),
  ];

  List<ChatMessage> get messages => _messages;

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void insertMessage(int index, ChatMessage message) {
    _messages.insert(index, message);
    notifyListeners();
  }
}
