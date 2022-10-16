import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.width * 0.3),
            Text(
              "YOĞUN GEÇEN GÜNLERDE YAPMAN GEREKENLERİ UNUTMAK ÇOK MU SIKICI",
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: Get.width * 0.045,
                  color: Color.fromARGB(255, 42, 79, 97),
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
            SizedBox(height: Get.width * 0.12),
            Lottie.asset("animations/s1.zip")
          ],
        ),
      ),
    );
  }
}