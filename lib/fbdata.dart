import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FbData {

  verilericek(){
    CollectionReference db = FirebaseFirestore.instance.collection("notes");

    db.add({
      "baslik": "merhaba ilk notum",
      "icerik": "merhaba ilk notumun icerigi"
    }).whenComplete(() {
      return Navigator.pop;
    })
    ;
  }

}