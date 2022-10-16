import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';

class CardDesign extends StatelessWidget {
  final String title;
  final String note;
  const CardDesign(
    this.title, 
    this.note, 
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerSelect controllerSelect = Get.put(ControllerSelect());
    return 
    Obx((() {
      return controllerSelect.themeDark.value == false ?
      Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      color: const Color.fromARGB(255, 237, 240, 255),
      margin: EdgeInsets.all(Get.width * 0.05),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Get.width * 0.045,
              ),
            ),
            SizedBox(
              height: Get.width * 0.01,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8, top: 2),
                child: Text(
                  note,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: Get.width * 0.033
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ):
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      margin: EdgeInsets.all(Get.width * 0.05),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Get.width * 0.045,
              ),
            ),
            SizedBox(
              height: Get.width * 0.01,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8, top: 2),
                child: Text(
                  note,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: Get.width * 0.033
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    }));
      
  }
}