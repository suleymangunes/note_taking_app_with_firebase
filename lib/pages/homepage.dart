import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/addnote.dart';
import 'package:not_uygulamasi/pages/editnote.dart';
import 'package:not_uygulamasi/widgets/card_design.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference db = FirebaseFirestore.instance.collection("notes");
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Taking App'),
      ),
      body: StreamBuilder<Object>(
        stream: db.orderBy("tarih", descending: true).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
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
                  print(snapshot.data.docs[0].data());
                }),
                child: CardDesign(
                  snapshot.data.docs[index].data()["baslik"].toString(),
                  snapshot.data.docs[index].data()["icerik"].toString()
                )
              );
            })
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Get.to(const AddNote());
        }),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
      icons: <IconData>[
        Icons.brightness_5,
        Icons.brightness_4,
        Icons.brightness_6,
        Icons.brightness_7,
      ],
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
   ),
    );
  }
}

