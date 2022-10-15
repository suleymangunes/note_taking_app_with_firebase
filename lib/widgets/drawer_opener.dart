import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/main.dart';
import 'package:not_uygulamasi/pages/auth_page.dart';
import 'package:not_uygulamasi/service/auth.dart';

class DrawerOpener extends StatefulWidget {
  const DrawerOpener(this.db, {
    Key? key,
  }) : super(key: key);

  final CollectionReference<Object?> db;

  @override
  State<DrawerOpener> createState() => _DrawerOpenerState();
}

class _DrawerOpenerState extends State<DrawerOpener> {
  final AuthService _authService = AuthService();

  final CollectionReference db2 = FirebaseFirestore.instance.collection("Person");

  @override
  Widget build(BuildContext context) {
    return 
    
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance.collection("Person").doc(_authService.infouser()).snapshots(),
    //   builder: ((context, AsyncSnapshot snapshot) {
    //     return Text(snapshot.data.data().toString().split(",")[1].toString().substring(11));
    //   })
    // );

      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Person").doc(_authService.infouser()).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return SafeArea(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 34.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("images/apple1.png"),
                        fit: BoxFit.scaleDown
                      )
                    ),
                    // child: Image.asset(
                    //   'assets/images/flutter_logo.png',
                    // ),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        snapshot.data.data().toString().split(",")[1].toString().substring(11),
                        style: TextStyle(
                          fontSize: Get.width * 0.08,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      db2.doc().get().then((value) => print(value.id));
                      print(db2.doc(_authService.infouser()).snapshots().first.then((value) => print(value.data())));
                      // db2.doc(_authService.infouser()).collection("notes").add({
                      //   "ekle": "merhaba"
                      // });
                    },
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {
                      print(_authService.infouser());
                    },
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    onTap: (() {
                      _authService.signOut().whenComplete((){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
                          return PageViewDesign();
                        })));
                        print("cikis yapti");
                      });
          
                    }),
                    leading: Icon(Icons.logout_rounded),
                    title: Text('Çıkış Yap'),
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          );
          }
          else{
            return Text("");
          }
          
        }
      );
  }
}