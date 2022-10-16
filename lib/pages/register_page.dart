import 'package:email_validator/email_validator.dart';
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
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  width: Get.width * 0.5,
                  child: Image.asset("images/appleb.png")),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: controllerName,
                    decoration: InputDecoration(
                      hintText: "namesur".tr
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'notnullname'.tr;
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
                        return 'emaildont'.tr;
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
                    decoration: InputDecoration(
                      hintText: "passw".tr
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'passwdont'.tr;
                      }
                      else if(controllerPassword.text.length < 8){
                        return 'pass8'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: controllerPasswordAgain,
                    decoration: InputDecoration(
                      hintText: "passag".tr
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'passwdont'.tr;
                      }
                      if(controllerPassword.text != controllerPasswordAgain.text){
                        return 'passame'.tr;
                      }
                      else if(controllerPasswordAgain.text.length < 8){
                        return 'pass8'.tr;
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
                        titleText: Text("regok".tr),
                        messageText: Text("plsign".tr),
                        icon: const Icon(Icons.done, color: Colors.green),
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        animationDuration: const Duration(seconds: 1),
                      );
                      }
                      );
                    }
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                      : Text("reg".tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}