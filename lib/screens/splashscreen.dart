// import 'package:dna/screen/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/questionanspage.dart';
import '../../common/widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QueAnsPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          Image.asset(
            'assets/splash.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: height * 0.08),
                    Image.asset(
                      'assets/bot1.png',
                      color: Colors.white,
                      fit: BoxFit.fill,
                      height: height * 0.4,
                      width: width * 0.6,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
