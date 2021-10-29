import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat app'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text('hello'),
              )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/P9NaRGedC3a1Z7SeSBlR/messages')
                .snapshots()
                .listen((data) {
              print(data);
            });
          }),
    );
  }
}
