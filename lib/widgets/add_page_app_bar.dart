import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPageAppBar extends StatelessWidget with PreferredSizeWidget {

  const AddPageAppBar({
    Key? key,
    required this.db,
    required this.title,
    required this.note,
  }) : super(key: key);

  final CollectionReference<Object?> db;
  final TextEditingController title;
  final TextEditingController note;

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.02),
            child: IconButton(
            onPressed: (() {
              if(title.text.isEmpty && note.text.isEmpty){
                Get.snackbar(
                "",
                "",
                titleText: const Text("Kaydetmek için bir şeyler yazın."),
                messageText: const Text("Başarısız"),
                icon: const Icon(Icons.warning_amber_rounded, color: Colors.yellow),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                animationDuration: const Duration(seconds: 1),
                );
              }
              else{
                db.orderBy("id").get().then((value) {
                  if (value.docs.isNotEmpty){
                    db.add({
                      "id": value.docs.last["id"] + 1,
                      "baslik": title.text,
                      "icerik": note.text,
                      "tarih": Timestamp.now(),
                      "archive": false
                    }).whenComplete(() => Navigator.pop(context)).
                    whenComplete(() => Get.snackbar(
                      "",
                      "",
                      titleText: const Text("Yeni Not Eklendi"),
                      messageText: const Text("Başarılı"),
                      icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.TOP,
                      animationDuration: const Duration(seconds: 1),
                    ));
                  }else{
                    db.add({
                      "id": 1,
                      "baslik": title.text,
                      "icerik": note.text,
                      "tarih": Timestamp.now(),
                      "archive": false
                    }).whenComplete(() => Navigator.pop(context)).
                    whenComplete(() => Get.snackbar(
                      "",
                      "",
                      titleText: const Text("Yeni Not Eklendi"),
                      messageText: const Text("Başarılı"),
                      icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.TOP,
                      animationDuration: const Duration(seconds: 1),
                    ));
                  }
                  
                });
              }
            }), 
            icon: Icon(
              Icons.save_as_rounded,
              size: Get.width * 0.07,
            )
        ),
          ),
        ],
      ),
    );
  }
}

