import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
    required this.isFromLoggedInUser,
  }) : super(key: key);

  final String sender, text;
  final bool isFromLoggedInUser;

  BorderRadius getBorderRadius() {
    if (isFromLoggedInUser) {
      return const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0));
    } else {
      return const BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0));
    }
  }

  Color getColor() {
    if (isFromLoggedInUser) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.grey;
    }
  }

  CrossAxisAlignment getAlignment() {
    if (isFromLoggedInUser) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Column(
        crossAxisAlignment: getAlignment(),
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Material(
            elevation: 3.0,
            borderRadius: getBorderRadius(),
            color: getColor(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
