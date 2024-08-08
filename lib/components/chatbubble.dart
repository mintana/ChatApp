import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  

  const ChatBubble({
    super.key, 
    required this.message, 
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        decoration: BoxDecoration(
          color: isCurrentUser ? const Color.fromARGB(255, 194, 194, 194) : const Color.fromARGB(255, 232, 222, 133),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
