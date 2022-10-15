import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/pages/auth_page.dart';
import 'package:not_uygulamasi/service/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordAgain = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;


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
                    controller: controllerName,
                    decoration: const InputDecoration(
                      hintText: "İsim ve Soyisim"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'İsim alanı boş olamaz.';
                      }
                      return null;
                    },
                  ),
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
                      if(controllerPassword.text != controllerPasswordAgain.text){
                        return 'Şifreler aynı olmalıdır.';
                      }
                      else if(controllerPassword.text.length < 8){
                        return 'Şifre 8 karakterden fazla olmalıdır.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: controllerPasswordAgain,
                    decoration: const InputDecoration(
                      hintText: "Şifre Tekrar"
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre alanı boş olamaz.';
                      }
                      if(controllerPassword.text != controllerPasswordAgain.text){
                        return 'Şifreler aynı olmalıdır.';
                      }
                      else if(controllerPasswordAgain.text.length < 8){
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
                        _isLoading = true;
                      });
                      _authService.createPerson(controllerName.text, controllerEmail.text, controllerPassword.text)
                      .whenComplete(() {
                      Get.off(const AuthPAge());
                      Get.snackbar(
                        "", 
                        "",
                        titleText: const Text("Kaydolma işlemi tamamladı"),
                        messageText: const Text("Lütfen Giriş Yapın"),
                        icon: const Icon(Icons.done, color: Colors.green),
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        animationDuration: const Duration(seconds: 1),
                      );
                      }
                      )
                      ;
                    }
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                      : const Text("Kaydol"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}