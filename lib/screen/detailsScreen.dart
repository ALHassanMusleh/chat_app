import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({required this.id});

  int id;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: messages.get(),
        builder: (context, snapshot) {
          // print(id);
          print('/////////////////////////////');
          if (snapshot.hasData) {
            print(snapshot.data!.docs[id]['message']);
            return Scaffold(
              body: Center(
                child: Text(snapshot.data!.docs[id]['message'] +
                    " " +
                    snapshot.data!.docs[id]['id']),
              ),
            );
          } else {
            return Text('LOading');
          }
        });
  }
}
