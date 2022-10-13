import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';
import 'package:not_uygulamasi/pages/editnote.dart';
import 'package:not_uygulamasi/widgets/card_design.dart';

class NoteNormalPage extends StatefulWidget {
  const NoteNormalPage(
    this.db, 
    {Key? key}) : super(key: key);

  final CollectionReference<Object?> db;
  @override
  State<NoteNormalPage> createState() => _NoteNormalPageState();
}

class _NoteNormalPageState extends State<NoteNormalPage> {

  ControllerSelect controllerSelect = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.db.where("archive", isEqualTo: false).orderBy("tarih", descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasError){
          Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: Get.width * 0.1,),
              const Text(
                "Hata oluştu tekrar deneyin"
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          CircularProgressIndicator();
        }
        return 
        GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.hasData 
          ?
          snapshot.data.docs.length
          :
          0
          ,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemBuilder: ((context, index) {
            return 
            GestureDetector(
              onTap: (() {
                Get.to(EditNote(data: snapshot.data.docs[index]));
              }),
              child: CardDesign(
                snapshot.data.docs[index].data()["baslik"].toString(),
                snapshot.data.docs[index].data()["icerik"].toString()
              )
            );
          })
        );
      }
    );
  }
}