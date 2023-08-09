import 'package:chat_app/constant.dart';

class Message {
  final String message;
  final String id;

  //وممكن كمان نحط التاريخ
  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[KMessages], jsonData['id']);
  }
}
