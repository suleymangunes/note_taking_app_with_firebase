import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddForm extends StatelessWidget {
  const AddForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.title,
    required this.note,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController title;
  final TextEditingController note;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(
                  fontSize: Get.width * 0.07
                ),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "baslik".tr,
                ),
                controller: title,
                validator: ((value) {
                  if (title.text.isEmpty) {
                    return 'textenter'.tr;
                  }
                  return null;
                }),
              ),
            ),
          ),
          Divider(
            indent: Get.width * 0.2,
            endIndent: Get.width * 0.2,
          ),
          Expanded(
            flex: 9,
            child: SizedBox(
              width: Get.width * 0.95,
              child: TextFormField(
                style: TextStyle(
                  fontSize: Get.width * 0.05
                ),
                maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "not".tr
              ),
              controller: note,
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'textenter'.tr;
                }
                return null;
              }),
              ),
            ),
          )
        ],
      ),
    );
  }
}