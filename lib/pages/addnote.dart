import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/forms/add_form.dart';


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
                "",
                "",
                titleText: const Text("Kaydedildi"),
                messageText: const Text("Başarılı"),
                icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                animationDuration: const Duration(seconds: 1),
               ));
            }), 
            child: const Text("kaydet")
          )
        ],
      ),
      body: AddForm(formKey: _formKey, title: title, note: note),
    );
  }
}

