import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  // sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password);

         _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid
      }, SetOptions(merge:true));

    return userCredential;
    } 
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
    }

  // create New user
 Future<UserCredential> signUpWithEmailAndPassword(
  String email,
  String password,
  String name,       // New parameter for the user's name
  String number      // New parameter for the user's phone number
) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    // Create new document with additional fields
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'uid': userCredential.user!.uid,
      'name': name,         // Save the user's name
      'number': number      // Save the user's phone number
    });

    return userCredential;
  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}


}