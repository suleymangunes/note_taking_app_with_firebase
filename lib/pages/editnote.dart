import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/forms/edit_form.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot data;
  const EditNote( {Key? key, required this.data}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  
  final _formKey = GlobalKey<FormState>();
  CollectionReference db = FirebaseFirestore.instance.collection("notes");

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.data["baslik"]);
    note = TextEditingController(text: widget.data["icerik"]);
    super.initState();
  }

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
              widget.data.reference.update({
                "baslik": title.text,
                "icerik": note.text
              }).whenComplete(() => Navigator.pop(context)).
              whenComplete(() =>  Get.snackbar(
                "",
                "",
                titleText: const Text("Güncellendi"),
                messageText: const Text("Başarılı"),
                icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                animationDuration: const Duration(seconds: 1),
               ));
            }), 
            child: const Text("guncelle")
          )
        ],
      ),
      body: EditForm(formKey: _formKey, title: title, note: note),
    );
  }
}

