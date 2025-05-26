import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:focuswork/homepage.dart';

class Onboarding extends StatefulWidget {
  Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const Homepage()));
  }

  Widget _buildImage(
    String assetName, [
    double width = 390,
    double height = 260,
  ]) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/$assetName',
        fit: BoxFit.contain, // or BoxFit.cover depending on your needs
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = GoogleFonts.rubik(
      fontSize: 20.0,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    );

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Circular",
      ),
      bodyTextStyle: bodyStyle,

      bodyPadding: EdgeInsets.symmetric(vertical: 0),
      pageColor: Color.fromARGB(255, 38, 38, 38),
      imagePadding: EdgeInsets.symmetric(vertical: 20),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color.fromARGB(255, 38, 38, 38),
      allowImplicitScrolling: false,
      autoScrollDuration: 10000,
      infiniteAutoScroll: false,
      pages: [
        PageViewModel(
          titleWidget: Text(
            "The only productive app you need",
            style: TextStyle(
              color: Colors.white,
              fontSize: 46.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular",
              height: 1.2,
            ),
            textAlign: TextAlign.left,
          ),
          bodyWidget: Text(
            "Track time, set goals, and improve your productivity effortlessly.",
            style: GoogleFonts.rubik(
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),

          image: _buildImage('studio.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            "Understand Your App Habits",
            style: TextStyle(
              color: Colors.white,
              fontSize: 46.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular",
              height: 1.2,
            ),
            textAlign: TextAlign.left,
          ),
          bodyWidget: Text(
            "Automatically track how much time you spend on each app. Identify where your time goes and start making smarter choices.",
            style: GoogleFonts.rubik(
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),

          image: _buildImage('habitsed.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back, color: Colors.white),
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          fontFamily: "Circular",
          color: Colors.white,
        ),
      ),
      next: const Icon(Icons.arrow_forward, size: 25, color: Colors.white),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          fontFamily: "Circular",
          color: Color.fromRGBO(255, 138, 0, 1.0),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding:
          kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: Colors.white,
        color: Color(0xFF1877F2),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color.fromARGB(255, 38, 38, 38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
