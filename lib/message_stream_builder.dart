import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    Key? key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
  })  : _stream = stream,
        super(key: key);

  final Stream<QuerySnapshot> _stream;

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
            List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
            return ListView(
              children: messages
                  .map(
                    (doc) => MessageBubble(
                      sender: doc.get('sender'),
                      text: doc.get('text'),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
