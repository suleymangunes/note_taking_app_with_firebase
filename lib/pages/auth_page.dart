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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    return null;
                  },
                ),
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
                child: const Text("merhaba"
                )
              ),
              ElevatedButton(
                onPressed: (() {
                  Get.to(const RegisterPage());
                }),
                child: const Text(
                  "kaydol"
                ),
              ),
              ElevatedButton(
                onPressed: (() {
                  _authService.issignin();
                }), 
                child: const Text("giris yapmis mi")
              ),
              ElevatedButton(
                onPressed: (() {
                  _authService.signOut();
                }), 
                child: const Text("cikis yap")
              )
            ],
          ),
        ),
      ),
    );
  }
}