import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focuswork/homepage.dart';
import 'package:focuswork/onboarding.dart';
import 'package:focuswork/splashscreen.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final _controller = WiseSplashScreen.createController(this);

  @override
  void initState() {
    super.initState();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
    });

    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: WiseSplashScreen(controller: _controller),
    );
  }
}
