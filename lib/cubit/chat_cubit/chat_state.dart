import 'package:chat_app/model/message.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {
  List<Message> messagesList;

  ChatSuccessState({required this.messagesList});
}
