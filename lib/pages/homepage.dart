import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';
import 'package:not_uygulamasi/pages/addnote.dart';
import 'package:not_uygulamasi/pages/archivenotepage.dart';
import 'package:not_uygulamasi/pages/normalnotepage.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'package:not_uygulamasi/widgets/bottom_nav_home.dart';
import 'package:not_uygulamasi/widgets/drawer_opener.dart';
import 'package:not_uygulamasi/widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ControllerSelect controllerSelect = Get.put(ControllerSelect());
  CollectionReference db = FirebaseFirestore.instance.collection("Person").doc(AuthService().infouser()).collection("notes");
  final _advancedDrawerController = AdvancedDrawerController();

  void handleMenuButtonPressed() {
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: DrawerOpener(db),
      child: Scaffold(
        appBar: HomeAppBar(handleMenuButtonPressed),
        body: Obx((() {
          return controllerSelect.bottomNavIndex.value == 0 
          ? 
          NoteNormalPage(db)
          : 
          ArchiveNormalPage(db);
        })),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: (() {
            Get.to(const AddNote());
          }),
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: Get.width * 0.08,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavDesign()
      ),
    );
  } 
}