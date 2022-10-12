import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';
import 'package:not_uygulamasi/pages/addnote.dart';
import 'package:not_uygulamasi/pages/archivenotepage.dart';
import 'package:not_uygulamasi/pages/normalnotepage.dart';
import 'package:not_uygulamasi/widgets/bottom_nav_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ControllerSelect controllerSelect = Get.put(ControllerSelect());

  CollectionReference db = FirebaseFirestore.instance.collection("notes");
  final _advancedDrawerController = AdvancedDrawerController();



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
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                // child: Image.asset(
                //   'assets/images/flutter_logo.png',
                // ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (() {
              _handleMenuButtonPressed();
            }), 
            icon: Icon(
              Icons.menu,
              size: Get.width * 0.07,
            )
          ),
          title: const Text(
            'Note Taking App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.02),
              child: IconButton(
                onPressed: (() {
                  
                }),
                icon: Icon(
                  Icons.search_outlined,
                  size: Get.width * 0.07,
                ),
              ),
            )
          ],
        ),


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
        bottomNavigationBar: BottomNavDesign()
      ),
    );
  }
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
