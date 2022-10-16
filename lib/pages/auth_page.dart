import 'package:email_validator/email_validator.dart';
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
  bool ticksign = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
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
                      return EmailValidator.validate(value) ? null : "Please enter a valid email";
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: controllerPassword,
                    decoration: const InputDecoration(
                      hintText: "Şifre"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre alanı boş olamaz.';
                      }
                      else if(controllerPassword.text.length < 8){
                        return 'Şifre 8 karakterden fazla olmalıdır.';
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
                      setState(() {
                        ticksign = true;
                      });
                      _authService.signIn(controllerEmail.text, controllerPassword.text)
                      .onError((error, stackTrace) {
                        Get.offAll(const AuthPAge());
                        Get.defaultDialog(
                          title: "GİRİŞ YAPILAMADI",
                          content: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                            style: TextStyle(color: Colors.black,fontSize: Get.width * 0.04),
                            children: const [
                              TextSpan(text: "Kullanıcı adı ", style: TextStyle(fontWeight: FontWeight.w500,)),
                              TextSpan(text: "ya da "),
                              TextSpan(text: "Şifre ", style: TextStyle(fontWeight: FontWeight.w500)),
                              TextSpan(text: "hatalı.\nLütfen tekrar deneyiniz.")
                            ]
                          )),
                          radius: 10,
                          backgroundColor: const Color.fromARGB(255, 167, 187, 196),
                          contentPadding: const EdgeInsets.all(20),
                          titlePadding: const EdgeInsets.only(top: 20),
                          confirm: ElevatedButton(
                            onPressed: (){
                              Get.back();
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                            child: const Text("Tekrar Dene")
                            ),
                        );
                        return null;
                          })
                      .then((value) {
                        if(value != null){
                          if(value.email!.isNotEmpty){
                            Get.snackbar(
                              "", 
                              "",
                              titleText: const Text("Giriş Yapıldı"),
                              messageText: const Text("Hemen Not Almaya Başla."),
                              icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                              backgroundColor: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              animationDuration: const Duration(seconds: 1),
                            );
                            Get.offAll(const HomePage());
                          }
                        }
                      });
                    }
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                  child: ticksign? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2) :const Text("Giriş Yap"),
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