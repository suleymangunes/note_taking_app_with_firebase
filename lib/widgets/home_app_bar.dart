import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget{
  const HomeAppBar(this.handleMenuButtonPressed, {Key? key}) : super(key: key);
  final void Function() handleMenuButtonPressed;
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: (() {
          widget.handleMenuButtonPressed();
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
          child: Icon(
            Icons.apple_rounded,
            size: Get.width * 0.07,
          ),
        )
      ],
    );
  }
}