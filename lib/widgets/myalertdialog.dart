import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/editnote.dart';

longAlert(String baslik, String icerik, doc, ){
  return Get.defaultDialog(
    radius: 10,
    titlePadding: EdgeInsets.only(top: Get.width * 0.05, left: Get.width * 0.05, right: Get.width * 0.05),
    title: baslik,
    titleStyle: TextStyle(
      fontSize: Get.width * 0.06
    ),
    content: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.width * 0.01, right: Get.width * 0.05, left: Get.width * 0.05),
          child: SizedBox(
            height: Get.width * 0.2,
            child: SingleChildScrollView(
              child: Text(
                icerik,
                style: TextStyle(
                  fontSize: Get.width * 0.05
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (() {
                Get.back();
                Get.to(EditNote(data: doc));
              }),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
              ), 
              child: Text("edit".tr),
            ),
            ElevatedButton(
              onPressed: (() {
                doc.reference.delete().whenComplete(() => Get.back());
              }),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
              ), 
              child: Text("dela".tr),
            )
          ],
        ),
      ],
    )
  );
}