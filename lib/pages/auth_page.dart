import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/homepage.dart';
import 'package:not_uygulamasi/pages/register_page.dart';
import 'package:not_uygulamasi/service/auth.dart';

class AuthPAge extends StatefulWidget {
  const AuthPAge({Key? key}) : super(key: key);

  @override
  State<AuthPAge> createState() => _AuthPAgeState();
}

class _AuthPAgeState extends State<AuthPAge> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  width: Get.width * 0.5,
                  child: Image.asset("images/apple1.png")),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(
                      hintText: "Email"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email alanı boş olamaz.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: controllerPassword,
                    decoration: const InputDecoration(
                      hintText: "Şifre"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre alanı boş olamaz.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: (() {
                    if (_formKey.currentState!.validate()) {
                      _authService.signIn(controllerEmail.text, controllerPassword.text).whenComplete(() {
                       Get.offAll(const HomePage());
                      } 
                      );
                    }
                  }),
                  child: const Text("Giriş Yap"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    Get.to(const RegisterPage());
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: const Text(
                    "Kaydol",
                    style: TextStyle(
                      color: Color.fromARGB(255, 55, 68, 74)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}