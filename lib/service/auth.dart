import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/auth_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password)
        // .catchError(
        //   (dynamic error){
        //     Get.snackbar("hata", "hatali giris");
        //   }
        // )
        ;
    print("*****\n************\n***************\n*****************\n**********${user.user}");
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }
  
  issignin(){
    return _auth.currentUser;
  }

  infouser(){
    return _auth.currentUser?.uid;
  }

  Future<User?> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password)
        ;

    await _firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email, "password": password});

    return user.user;
  }
}