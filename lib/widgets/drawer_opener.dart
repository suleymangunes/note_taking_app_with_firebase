import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_uygulamasi/controllers/controller_select.dart';
import 'package:not_uygulamasi/pages/pageviewpage.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'package:not_uygulamasi/themes/normaltheme.dart';
import 'package:not_uygulamasi/widgets/changelang.dart';

class DrawerOpener extends StatefulWidget {
  const DrawerOpener(this.db, {
    Key? key,
  }) : super(key: key);

  final CollectionReference<Object?> db;

  @override
  State<DrawerOpener> createState() => _DrawerOpenerState();
}

class _DrawerOpenerState extends State<DrawerOpener> {
  final AuthService _authService = AuthService();

  final CollectionReference db2 = FirebaseFirestore.instance.collection("Person");
  ControllerSelect controllerSelect = Get.find();

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Person").doc(_authService.infouser()).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return 
            Obx((() {
              return controllerSelect.themeDark.value == false ?
              SafeArea(
                child: ListTileTheme(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  child: Container(
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: Get.width * 0.3,
                          height: Get.width * 0.3,
                          margin: EdgeInsets.only(
                            top: Get.width * 0.15,
                            bottom: Get.width * 0.1,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("images/appleb.png"),
                              fit: BoxFit.scaleDown
                            )
                          ),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              snapshot.data.data().toString().split(",")[1].toString().substring(11),
                              style: TextStyle(
                                fontSize: Get.width * 0.08,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            if (controllerSelect.themeDark.value == false){
                              controllerSelect.themeDark.value = true;
                            }else{
                              controllerSelect.themeDark.value = false;
                            }
                            Get.changeTheme(controllerSelect.themeDark.value == false? themeDataApp(): ThemeData.dark());
                          },
                          leading: const Icon(Icons.dark_mode_outlined),
                          title: Text('dark'.tr),
                        ),
                        const ChangeLang(),
                        ListTile(
                          onTap: (() {
                            _authService.signOut().whenComplete((){
                              Get.changeTheme(themeDataApp());
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
                                return const PageViewDesign();
                              })));
                            });
                          }),
                          leading: const Icon(Icons.logout_rounded),
                          title: Text('out'.tr),
                        ),
                        const Spacer(),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Text('terms'.tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              :
              SafeArea(
                child: ListTileTheme(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  child: Container(
                    color: const Color.fromARGB(255, 28, 28, 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: Get.width * 0.3,
                          height: Get.width * 0.3,
                          margin: EdgeInsets.only(
                            top: Get.width * 0.15,
                            bottom: Get.width * 0.1,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("images/applew.png"),
                              fit: BoxFit.scaleDown,
                            )
                          ),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              snapshot.data.data().toString().split(",")[1].toString().substring(11),
                              style: TextStyle(
                                fontSize: Get.width * 0.08,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            if (controllerSelect.themeDark.value == false){
                              controllerSelect.themeDark.value = true;
                            }else{
                              controllerSelect.themeDark.value = false;
                            }
                            Get.changeTheme(controllerSelect.themeDark.value == false ? themeDataApp(): ThemeData.dark());
                          },
                          leading: const Icon(Icons.dark_mode_rounded),
                          title: Text('light'.tr),
                        ),
                        const ChangeLang(),
                        ListTile(
                          onTap: (() {
                            _authService.signOut().whenComplete((){
                              Get.changeTheme(themeDataApp());
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
                                return const PageViewDesign();
                              })));
                            });
                          }),
                          leading: const Icon(Icons.logout_rounded),
                          title: Text('out'.tr),
                        ),
                        ListTile(
                          onTap: () {
                            print(Get.isDarkMode);
                          },
                          title: Text("tikla"),
                        ),
                        const Spacer(),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Text('terms'.tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
          }
          else{
            return const Text("");
          }
        }
      );
  }
}