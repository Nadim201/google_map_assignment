import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_map_assignment/ui/auth/login_screen.dart';
import 'package:google_map_assignment/ui/main/home_page.dart';

class FirebaseHelper {
  void isLogging(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Get.to(
          GoogleMapsAssignment(),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Get.to(
          SignIn(),
        ),
      );
    }
  }
}
