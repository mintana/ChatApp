import 'package:chatapp/components/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chats extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send msg
  Future<void> sendMessage(String receiverId, String message) async {
    
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUseremail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    final userDoc = await _firestore.collection('users').doc(currentUserId).get();
    final String senderName = userDoc.data()?['name'];

    // create new msg
    Message newMessage = Message(
        senderId: currentUserId,
        receiverId: receiverId,
        senderName: senderName,
        message: message,
        timestamp: timestamp);

    // chat room id from user id and receiver id
    List<String> id = [currentUserId, receiverId];
    id.sort();
    String chatRoomId = id.join(" - ");

    // add new msg to db
    await _firestore
        .collection('Chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get msg
  Stream<QuerySnapshot> getMessages(String userId, String userId2) {
    List<String> id = [userId, userId2];
    id.sort();
    String chatRoomId = id.join(" - ");

    return _firestore
        .collection('Chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}
