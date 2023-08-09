import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/screen/detailsScreen.dart';
import 'package:chat_app/widgets/CustomChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Alldata extends StatelessWidget {
  Alldata({Key? key}) : super(key: key);
  final ScrollController _controller = ScrollController();

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // future: messages.doc("717JroUqoRSVR7hr63Qu").get(),
      // future: messages.get(), //return QuerySnapshot
      stream: messages.snapshots(),
      builder: (context, snapshot) {
        // print(snapshot.data!['message']);  //Instance of '_JsonDocumentSnapshot'
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
                      reverse:
                          true, //بعكس الليست فيو البداية بتصير نهاسة والنهاية بتصير البداية
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                id: index,
                              );
                            }));
                          },
                          child: CustomChatBubble(
                            message: messagesList[index],
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
