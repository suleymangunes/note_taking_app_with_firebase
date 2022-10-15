import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditForm extends StatelessWidget {
  const EditForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.title,
    required this.note, 
    required this.data,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController title;
  final TextEditingController note;
  final DocumentSnapshot<Object?> data;

  Future<bool?> showwarning(BuildContext context) async => showDialog<bool>(
    context: context, 
    builder: ((context) {
      return AlertDialog(
        title: const Text("Değişiklikleri kaydetmek ister misin?"),
        actions: [
          ElevatedButton(
            onPressed: (() {
              return Navigator.pop(context, false);
            }), 
            child: const Text("Hayır")
          ),
          ElevatedButton(
            onPressed: (() {
              return Navigator.pop(context, true);
            }), 
            child: const Text("Evet")
          )
        ],
      );
    })
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(
                  fontSize: Get.width * 0.07
                ),
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                controller: title,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
              ),
            ),
          ),
          Divider(
            indent: Get.width * 0.2,
            endIndent: Get.width * 0.2,
          ),
          Expanded(
            flex: 9,
            child: SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(
                  fontSize: Get.width * 0.05
                ),
                maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note"
              ),
              controller: note,
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
              ),
            ),
          )
        ],
      ),
    );
  }
}