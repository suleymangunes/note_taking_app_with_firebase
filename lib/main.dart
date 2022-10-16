import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/language/langs.dart';
import 'package:not_uygulamasi/options/firebase_options.dart';
import 'package:not_uygulamasi/pages/pageviewpage.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'package:not_uygulamasi/themes/normaltheme.dart';
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
      title: 'Not Uygulamasi',
      translations: Messages(),
      locale: const Locale("tr", "TR"),
      debugShowCheckedModeBanner: false,
      theme: themeDataApp(),
      home:
      _authService.issignin() == null?
      const PageViewDesign()
      :
      const HomePage()
      ,
    );
  }
}