import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/options/firebase_options.dart';
import 'package:not_uygulamasi/pages/auth_page.dart';
import 'package:not_uygulamasi/pages/register_page.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'pages/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 167, 187, 196),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          color: const Color.fromARGB(255, 167, 187, 196),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          )
        ),
        primarySwatch: Colors.blue,
      ),
      home: 
      _authService.issignin() == null?
      const AuthPAge()
      :
      const HomePage()
      ,
    );
  }
}