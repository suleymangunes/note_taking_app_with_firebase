import 'package:flutter/material.dart';
import 'package:not_uygulamasi/intro_screens/intropage1.dart';
import 'package:not_uygulamasi/intro_screens/intropage2.dart';
import 'package:not_uygulamasi/intro_screens/intropage3.dart';
import 'package:not_uygulamasi/intro_screens/intropage4.dart';
import 'package:not_uygulamasi/intro_screens/intropage5.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewDesign extends StatefulWidget {
  const PageViewDesign({super.key});

  @override
  State<PageViewDesign> createState() => _PageViewDesignState();
}

class _PageViewDesignState extends State<PageViewDesign> {

  final PageController _controller = PageController();

  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index){
              setState(() {
                lastPage = (index == 5);
              });
            },
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          children: const <Widget>[
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
            IntroPage4(),
            IntroPage5(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // GestureDetector(
                  //   onTap: (() {
                  //     _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  //   }),
                  //   child: Text("Önceki")
                  // ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 5,
                    effect: const WormEffect(
                      activeDotColor: Color.fromARGB(255, 82, 103, 114),
                      dotColor: Colors.grey
                    )
                  ),
                  // lastPage ?
                  // GestureDetector(
                  //   onTap: (() {
                  //     _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  //   }),
                  //   child: Text("Giriş Yap")
                  // )
                  // :
                  // GestureDetector(
                  //   onTap: (() {
                  //     _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  //   }),
                  //   child: Text("Sonraki")
                  // ),
                ],
              ),
            ],
          )
          )
        ],
      ),
    );
  }
}
