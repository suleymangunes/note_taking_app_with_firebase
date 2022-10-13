import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:not_uygulamasi/widgets/edit_form.dart';
import 'package:not_uygulamasi/widgets/edit_note_app_bar.dart';

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
      appBar: EditPageAppBar( title: title, note: note, widget: widget, data:widget.data, db: db),
      body: EditForm(formKey: _formKey, title: title, note: note, data:widget.data),
    );
  }
}