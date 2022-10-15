import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/editnote.dart';
import 'package:not_uygulamasi/widgets/card_design.dart';

class ArchiveNormalPage extends StatefulWidget {
  const ArchiveNormalPage(this.db, {Key? key}) : super(key: key);

  final CollectionReference<Object?> db;
  @override
  State<ArchiveNormalPage> createState() => _ArchiveNormalPageState();
}

class _ArchiveNormalPageState extends State<ArchiveNormalPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.db.where("archive", isEqualTo: true).orderBy("tarih", descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.docs.length == 0){
          return Center(
            child: Card(
              color: const Color.fromARGB(255, 237, 240, 255),
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                  text: "Henüz Arşivinde hiç not yok.\nArşivine not eklemek için ",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: Get.width * 0.04,
                    ),
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.archive_outlined,
                        size: Get.width * 0.06,
                      ),
                      ),
                    const TextSpan(text: " butonuna bas.")
                  ]
                ))
              )
            ),
          );
        }
        }
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