import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:not_uygulamasi/main.dart';
import 'package:not_uygulamasi/pages/auth_page.dart';
import 'package:not_uygulamasi/service/auth.dart';

class DrawerOpener extends StatelessWidget {
  DrawerOpener(this.db, {
    Key? key,
  }) : super(key: key);

  final AuthService _authService = AuthService();
  final CollectionReference<Object?> db;
  final CollectionReference db2 = FirebaseFirestore.instance.collection("Person").doc(AuthService().infouser()).collection("notes");


  @override
  Widget build(BuildContext context) {
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
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: AssetImage("")
                // )
              ),
              // child: Image.asset(
              //   'assets/images/flutter_logo.png',
              // ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.home),
              title: Text(db.snapshots().first.toString()),
            ),
            ListTile(
              onTap: () {
                print(
                  db2.get().then((value) => print(value.docs[0].data()))
                );
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
                    return AuthPAge();
                  })));
                  print("cikis yapti");
                });

              }),
              leading: Icon(Icons.logout_rounded),
              title: Text('cikis'),
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
}