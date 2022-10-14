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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.8,
                child: TextFormField(
                  controller: controllerName,
                  decoration: const InputDecoration(
                    hintText: "Name"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
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
                    hintText: "email"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
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
                    hintText: "Password"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if(controllerPassword.text != controllerPasswordAgain.text){
                      return 'password not different';
                    }
                    else if(controllerPassword.text.length < 8){
                      return 'password shoul be greater than 8 character';
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
                    hintText: "Password Again"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if(controllerPassword.text != controllerPasswordAgain.text){
                      return 'password not different';
                    }
                    else if(controllerPasswordAgain.text.length < 8){
                      return 'password shoul be greater than 8 character';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: (() {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    print("calisti");
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
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : const Text("Kaydol"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}