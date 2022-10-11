import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final _formKey = GlobalKey<FormState>();
  CollectionReference db = FirebaseFirestore.instance.collection("notes");

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('not ekle'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: (() {
              db.add({
                "baslik": title.text,
                "icerik": note.text
              // ignore: void_checks
              }).whenComplete(() => Navigator.pop(context)).
              whenComplete(() => Get.snackbar(
              "GeeksforGeeks",
               "Hello everyone",
               icon: Icon(Icons.person, color: Colors.white),
               snackPosition: SnackPosition.BOTTOM,
                 
               ));
            }), 
            child: Text("kaydet")
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: Get.width * 0.95,
                child: TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                  controller: title,
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 9,
              child: SizedBox(
                width: Get.width * 0.95,
                child: TextFormField(
                  maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note"
                ),
                controller: note,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}