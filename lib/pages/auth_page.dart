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
                        Get.offAll(AuthPAge());
                        Get.defaultDialog(
                          title: "Kullanıcı Adı Ya Da Şifre Hatalı",
                          middleText: "Lütfen Tekrar Deneyin",
                        );
                        Get.snackbar(
                          "", 
                          "",
                          titleText: const Text("Kullanıcı Adı Ya Da Şifre Hatalı"),
                          messageText: const Text("Lütfen Tekrar Deneyin"),
                          icon: Icon(Icons.close_rounded, color: Colors.red, size: Get.width * 0.07,),
                          backgroundColor: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: Duration(seconds: 5),
                          );
                          })
                      .then((value) {
                        if(value != null){
                          if(value.email!.isNotEmpty){
                            Get.snackbar(
                              "", 
                              "",
                              titleText: const Text("Giriş Yapıldı"),
                              messageText: const Text("Başarılı"),
                              icon: const Icon(Icons.done_outline_rounded, color: Colors.green),
                              backgroundColor: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              animationDuration: const Duration(seconds: 1),
                            );
                            Get.offAll(const HomePage());
                          }
                        }
                      })
                        ;
                    }
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                  child: ticksign? const CircularProgressIndicator() :const Text("Giriş Yap"),
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
                ElevatedButton(
                  onPressed: (() {
                    Get.defaultDialog(
                      title: "GİRİŞ YAPILAMADI",
                      middleText: "Kullanıcı adı ya da şifre hatalı.\nLütfen Tekrar Deneyin",
                      radius: 10,
                      backgroundColor: Color.fromARGB(255, 237, 240, 255),
                      contentPadding: EdgeInsets.all(20),
                      titlePadding: EdgeInsets.only(top: 20),
                      confirm: Text("tamam")
                    );
                  }), 
                  child: Text("tikla")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}