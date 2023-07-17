import 'package:flutter/material.dart';
import 'package:intro_app/pages/home_page.dart';

import '../utilities/Strings.dart';

class IntroPage extends StatefulWidget {
  static const String id = 'intro_page';

  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          children: [
            myPage(
                image: 'assets/images/image_1.png',
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent,
                isSkip: false),
            myPage(
                image: 'assets/images/image_2.png',
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent,
                isSkip: false),
            myPage(
                image: 'assets/images/image_3.png',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent,
                isSkip: true),
          ],
        ),
        Container(
          height: double.infinity,
          margin: EdgeInsets.only(bottom: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _builder(),
          ),
        )
      ]),
    );
  }

  Widget myPage({image, title, content, isSkip}) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.green, fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(content,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center),
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            maintainState: isSkip,
            visible: isSkip,
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
              child: Container(
                padding: EdgeInsets.all(26),
                margin: EdgeInsets.only(bottom: 47),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      )
    ]);
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _builder() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
