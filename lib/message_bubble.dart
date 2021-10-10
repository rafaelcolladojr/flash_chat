import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.sender, required this.text})
      : super(key: key);

  final String sender, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
