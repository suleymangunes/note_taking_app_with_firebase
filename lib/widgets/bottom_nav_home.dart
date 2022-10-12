import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';

class BottomNavDesign extends StatefulWidget {
  const BottomNavDesign( {Key? key}) : super(key: key);

  @override
  State<BottomNavDesign> createState() => _BottomNavDesignState();
}

class _BottomNavDesignState extends State<BottomNavDesign> {

  ControllerSelect controllerSelect = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: const <IconData>[
        Icons.note_rounded,
        Icons.archive_rounded,
      ],
      iconSize: Get.width * 0.08,
      backgroundColor: Color.fromARGB(255, 220, 225, 252),
      inactiveColor: Colors.grey,
      activeIndex: controllerSelect.bottomNavIndex.value,
      activeColor: Colors.black87,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => controllerSelect.bottomNavIndex.value = index),
   );
  }
}