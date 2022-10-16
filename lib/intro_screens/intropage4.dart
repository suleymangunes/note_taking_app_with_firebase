import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.2),
            Text(
              "s4text".tr,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: Get.width * 0.045,
                  color: const Color.fromARGB(255, 42, 79, 97),
                  fontWeight: FontWeight.w800,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 10.0,
                      color: Colors.white,
                    ),
                  ],
                )
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.0512),
            Lottie.asset("animations/s4.zip")
          ],
        ),
      ),
    );
  }
}