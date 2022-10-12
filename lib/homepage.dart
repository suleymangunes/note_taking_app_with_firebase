import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/addnote.dart';
import 'package:not_uygulamasi/pages/editnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference db = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: StreamBuilder<Object>(
        stream: db.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.hasData 
            ?
            snapshot.data.docs.length
            :
            0
            ,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: (() {
                  Get.to(EditNote(data: snapshot.data.docs[index]));
                  print(snapshot.data.docs[0].data());
                }),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 10,
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(snapshot.data.docs[index].data()["baslik"].toString()),
                      Text(snapshot.data.docs[index].data()["icerik"].toString())
                    ],
                  ),
                ),
              );
            })
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Get.to(const AddNote());
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}