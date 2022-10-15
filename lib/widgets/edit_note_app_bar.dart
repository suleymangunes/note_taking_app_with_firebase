import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/editnote.dart';

class EditPageAppBar extends StatelessWidget with PreferredSizeWidget {

  const EditPageAppBar({
    Key? key,
    required this.widget,
    required this.title,
    required this.note,
    required this.data,
    required this.db,
  }) : super(key: key);

  final EditNote widget;
  final TextEditingController title;
  final TextEditingController note;
  final DocumentSnapshot<Object?> data;
  final CollectionReference<Object?> db;

  Future<bool?> showwarning(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text("Değişiklikleri kaydetmek ister misin?"),
        actions: [
          ElevatedButton(
            onPressed: (() {
              return Navigator.pop(context, true);
            }),
            child: const Text("Hayır")
          ),
          ElevatedButton(
            onPressed: (() {
              widget.data.reference.update({
                "baslik": title.text,
                "icerik": note.text
              }).whenComplete(() => Navigator.pop(context, true)).
              whenComplete(() =>  Get.snackbar(
                "",
                "",
                titleText: const Text("Güncellendi"),
                icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                animationDuration: const Duration(seconds: 1),
               ));
            }),
            child: const Text("Evet")
          )
        ],
      );
    })
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (data["icerik"] != note.text || data["baslik"] != title.text){
          final pop = await showwarning(context);
          return pop ?? false;
        }
        return true;
      },
      child: StreamBuilder<Object>(
        stream: db.where("id", isEqualTo: data["id"]).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          return AppBar(
            actions: [
              IconButton(
                onPressed: (() {
                  if(snapshot.data.docs[0].data()["archive"] == false){
                    widget.data.reference.update({
                    "baslik": title.text,
                    "icerik": note.text,
                    "tarih": Timestamp.now(),
                    "archive": true
                  }).
                  whenComplete(() =>  Get.snackbar(
                    "",
                    "",
                    titleText: const Text("Arşive eklendi"),
                    icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                    backgroundColor: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1)
                   ));
                  }
                  else if(snapshot.data.docs[0].data()["archive"] == true){
                    widget.data.reference.update({
                    "baslik": title.text,
                    "icerik": note.text,
                    "tarih": Timestamp.now(),
                    "archive": false
                  }).
                  whenComplete(() =>  Get.snackbar(
                    "",
                    "",
                    titleText: const Text("Arşivden Kaldırıldı"),
                    icon: const Icon(Icons.close, color: Colors.red),
                    backgroundColor: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1)

                   ));
                  }
                }),
                icon:
                snapshot.hasData ?
                snapshot.data.docs.isNotEmpty ?
                snapshot.data.docs[0].data()["archive"] == true
                ?
                Icon(Icons.archive_rounded, size: Get.width * 0.07)
                :
                Icon(Icons.archive_outlined, size: Get.width * 0.07)
                :
                const Icon(Icons.archive_sharp):
                const Icon(Icons.archive_sharp)
              )
              ,
              IconButton(
                onPressed: (() {
                  if(title.text.isEmpty && note.text.isEmpty){
                    Get.snackbar(
                  "",
                  "",
                  titleText: const Text("Güncellemek için bir şeyler yazın."),
                  icon: const Icon(Icons.warning_amber_rounded, color: Colors.yellow),
                  backgroundColor: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  animationDuration: const Duration(seconds: 1),
                  );
                  }
                  else{
                    widget.data.reference.update({
                    "baslik": title.text,
                    "icerik": note.text,
                    "tarih": Timestamp.now()
                  }).whenComplete(() => Navigator.pop(context)).
                  whenComplete(() =>  Get.snackbar(
                    "",
                    "",
                    titleText: const Text("Güncellendi"),
                    icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                    backgroundColor: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                   ));
                  }
                }),
                icon: Icon(Icons.update_rounded, size: Get.width * 0.07)
              ),
              IconButton(
                onPressed: (() {
                   widget.data.reference.delete().whenComplete(() => Navigator.pop(context))
                   .whenComplete(() => Get.snackbar(
                    "",
                    "",
                    titleText: const Text("Silindi"),
                    icon: const Icon(Icons.highlight_remove_rounded, color: Colors.red),
                    backgroundColor: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                    )
                  );
                }),
                icon: Icon(Icons.delete_forever_rounded, size: Get.width * 0.07,)
              ),
            ],
          );
        }
      ),
    );
  }
}