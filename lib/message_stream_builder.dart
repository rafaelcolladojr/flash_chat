import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
    required User loggedInUser,
  })  : _stream = stream,
        _loggedInUser = loggedInUser,
        super(key: key);

  final Stream<QuerySnapshot> _stream;
  final User _loggedInUser;

  bool isLoggedInUser(String email) {
    return email.toLowerCase() == _loggedInUser.email!.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Iterable<QueryDocumentSnapshot<Object?>> messages =
                snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: messages
                    .map(
                      (doc) => MessageBubble(
                        sender: doc.get('sender'),
                        text: doc.get('text'),
                        isFromLoggedInUser: isLoggedInUser(doc.get('sender')),
                      ),
                    )
                    .toList(),
                reverse: true,
              ),
            );
          }),
    );
  }
}
