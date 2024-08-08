import 'package:chatapp/pages/chatpage.dart';
import 'package:chatapp/utilities/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() async {
    final auth = Provider.of<Auth>(context, listen: false);
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final auth =
        Provider.of<Auth>(context, listen: false); 

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 60,
        title: const Text('Your Chats',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(
              CupertinoIcons.square_arrow_right,
              size: 30,
            ),
          ),
        ],
      ),
      body: usersLists(auth),
    );
  }

  Widget usersLists(Auth auth) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => userListItem(
                  doc, auth))
              .toList(),
        );
      },
    );
  }

  Widget userListItem(DocumentSnapshot document, Auth auth) {
    final data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return Container(); 
    }

    final name = data['name'] as String?;
    final uid = data['uid'] as String?;
    final email = data['email'] as String?;

    if (email != null && name != null && uid != null) {
      if (auth.currentUser?.email != email) {
        return Padding(
          padding: const EdgeInsets.only(top:10, bottom: 0, left: 20,right: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 222, 133),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
              subtitle: Text(email),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverUserID: uid,
                      receiverUserName: name,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    return Container(); 
  }
}
