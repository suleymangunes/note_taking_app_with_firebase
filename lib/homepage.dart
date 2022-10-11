import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/addnote.dart';

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
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              db.add({
                "baslik": "merhaba ilk notum",
                "icerik": "merhaba ilk notumun icerigi"
              // ignore: void_checks
              }).whenComplete(() {
                return Navigator.pop;
              }).whenComplete(() => print("eklendi"));
            },
            child: const Text(
              "ekle"
            ),
          )
        ],
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