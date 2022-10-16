import 'package:flutter/material.dart';
import 'package:get/get.dart';

ThemeData themeDataApp() {
  return ThemeData(
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
  );
}