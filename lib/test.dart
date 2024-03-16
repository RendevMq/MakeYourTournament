import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatelessWidget {
  // const Test({super.key});

      CollectionReference playsReference =
      FirebaseFirestore.instance.collection("plays");

  @override
  Widget build(BuildContext context) {

      playsReference.get().then((value) {
      QuerySnapshot productCollection = value;
      // print(productCollection.size);
      //print(productCollection.docs);

      List<QueryDocumentSnapshot> docs = productCollection.docs;
      // print(docs[1].id);
      //print(docs[1].data());

      docs.forEach((element) {
        print(element.data());
        // print(element.id);
      });
    });

    return const Placeholder();
  }
}