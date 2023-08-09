import 'package:chat_app/constant.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/chat_cubit/chat_state.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/screen/detailsScreen.dart';
import 'package:chat_app/widgets/CustomChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';

  final ScrollController _controller = ScrollController();

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments
        as String; //هيرجعلي الارجمنت الي بعتها
    // return StreamBuilder<QuerySnapshot>(
    //   // future: messages.doc("717JroUqoRSVR7hr63Qu").get(),
    //   // future: messages.get(), //return QuerySnapshot
    //   stream: messages.orderBy('createdAt', descending: true).snapshots(),
    //   // stream: messages.snapshots(),
    //   builder: (context, snapshot) {
    //     // print(snapshot.data!['message']);  //Instance of '_JsonDocumentSnapshot'
    //     if (snapshot.hasData) {
    //       List<Message> messagesList = [];
    //       for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //         messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
    //         print(snapshot.data!.docs[i]['id'] + " " +  snapshot.data!.docs[i]['message']);
    //       }
    // print(snapshot.data!.docs[1]['message']);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, //هيخفي الزر الي هيرجع على الصفحة الي قبل
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //klogo in constant
            Image.asset(kLogo, width: 50),
            Text('Scholar Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    reverse: true,
                    //بعكس الليست فيو البداية بتصير نهاسة والنهاية بتصير البداية
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? CustomChatBubble(
                              message: messagesList[index],
                            )
                          : CustomChatBubbleForFriend(
                              message: messagesList[index],
                            );
                    });
              },
              // listener: (context, state) {
              //   if (state is ChatSuccessState) {
              //     messagesList = state.messagesList;
              //   }
              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                // messages.add({
                //   KMessages: data,
                //   'createdAt': DateTime.now(),
                //   'id': email,
                // });
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(
                  // _controller.position.maxScrollExtent,
                  0, //بداية lsitview
                  duration: Duration(microseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 2,
                    )), //general
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 2,
                    )),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //     } else {
  //       return Scaffold(
  //         body: Center(child: CircularProgressIndicator()),
  //       );
  //     }
  //   },
  // );
}
