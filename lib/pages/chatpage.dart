import 'package:chatapp/components/chatbubble.dart';
import 'package:chatapp/components/textfield.dart';
import 'package:chatapp/utilities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final Chats _chats = Chats();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chats.sendMessage(widget.receiverUserID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 60,
        title: Text(widget.receiverUserName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //Messages
            Expanded(
              child: messageList(),
            ),

            //UserINput
            messageInput(),
          ],
        ),
      ),
    );
  }

  // Message List
  Widget messageList() {
    return StreamBuilder(
      stream: _chats.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => messageItem(document))
              .toList(),
        );
      },
    );
  }

  // Message Item
  Widget messageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return Container(); // Return an empty container if data is null
    }
    bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,

        children: [
              ChatBubble(message: data['message'], isCurrentUser: isCurrentUser,)
        ],
      ),
    );
  }

  // Input
  Widget messageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Text_Field(
                controller: messageController,
                text: 'Enter message',
                obscureText: false)),
                SizedBox(width: 10,),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 222, 133),
            borderRadius: BorderRadius.circular(25)
          ),
          child: IconButton(
            color: Colors.black,
              onPressed: sendMessage,
              icon: Icon(
                CupertinoIcons.paperplane_fill,
                size: 32,
              )),
        )
      ],
    );
  }
}
