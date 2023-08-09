import 'package:chat_app/constant.dart';
import 'package:chat_app/cubit/chat_cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/message.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<Message> messagesList = [];

  //send message logic
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        KMessages: message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (e) {}
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      // event.docs;
      // List<Message> messagesList = [];
      messagesList.clear();
      for (var docs in event.docs) {
        messagesList.add(Message.fromJson(docs));
      }
      print('success');
      emit(ChatSuccessState(messagesList: messagesList));
    });
  }
}
