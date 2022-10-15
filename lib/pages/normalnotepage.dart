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
                  text: "Henüz hiç notun yok.\nHemen oluşturmak için ",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: Get.width * 0.04,
                    ),
                  children: [
                    WidgetSpan(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 114, 149, 166), 
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          " + ",
                          style: TextStyle(fontSize: Get.width * 0.05,),
                        ),
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
          const CircularProgressIndicator();
        }
        if(snapshot.hasData){
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
        else{
          return const Text("");
        }
      }
    );
  }
}