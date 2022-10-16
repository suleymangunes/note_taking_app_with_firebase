import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';

class ChangeLang extends StatefulWidget {
  const ChangeLang({Key? key}) : super(key: key);

  @override
  State<ChangeLang> createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {

  ControllerSelect controllerSelect = Get.find();

  @override
  Widget build(BuildContext context) {
    return 
    Obx((() {
      return 
      controllerSelect.themeDark.value == false ?
      ListTile(
      onTap: () {
      },
      leading: const Icon(Icons.language_rounded),
      title: Text('lang'.tr),
      trailing: DropdownButton<String>(
          dropdownColor: Colors.blueGrey,
          focusColor: Colors.transparent,
          value: controllerSelect.dropdownValue.value,
          items: <String>['Turkish', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            controllerSelect.dropdownValue.value = newValue!;
            if (controllerSelect.dropdownValue.value == "English") {
              Get.updateLocale(const Locale("en", "US"));
            } else if (controllerSelect.dropdownValue.value == "Turkish") {
              Get.updateLocale(const Locale("tr", "TR"));
            }
          },
        ),
    ):
    ListTile(
      onTap: () {
      },
      leading: const Icon(Icons.language_rounded),
      title: Text('lang'.tr),
      trailing: DropdownButton<String>(
          focusColor: Colors.transparent,
          value: controllerSelect.dropdownValue.value,
          items: <String>['Turkish', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            controllerSelect.dropdownValue.value = newValue!;
            if (controllerSelect.dropdownValue.value == "English") {
              Get.updateLocale(const Locale("en", "US"));
            } else if (controllerSelect.dropdownValue.value == "Turkish") {
              Get.updateLocale(const Locale("tr", "TR"));
            }
          },
        ),
    );
    }));
  }
}