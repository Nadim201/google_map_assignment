import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_map_assignment/ui/utils_files/text_format.dart';

import '../../firebase_services/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseHelper helper = FirebaseHelper();

  @override
  void initState() {
    helper.isLogging(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/taxi.png',
                width: Get.width * 0.5,
                height: Get.width * 0.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Way To Home',
                style: TextFile.headerTextStyle().copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
