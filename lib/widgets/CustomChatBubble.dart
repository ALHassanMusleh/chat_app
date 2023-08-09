import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constant.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomChatBubbleForFriend extends StatelessWidget {
  const CustomChatBubbleForFriend({required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF006488),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
