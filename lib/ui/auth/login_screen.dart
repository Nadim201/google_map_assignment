import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_map_assignment/ui/main/home_page.dart';
import 'package:google_map_assignment/ui/auth/sign_up.dart';
import 'package:google_map_assignment/ui/utils_files/custom_snack_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils_files/color.dart';
import '../utils_files/text_format.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  bool isVisible = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    super.dispose();
  }

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.orangeAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height / 2.5),
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/taxi.png',
                    width: Get.width * 0.38,
                    height: Get.height * 0.20,
                    fit: BoxFit.cover,
                    // color: Colors.white,
                  ),
                  const SizedBox(height: 40),
                  InputFeildSection(size, context),
                ],
              ),
            ),
            SignInGoogle()
          ],
        ),
      ),
    );
  }

  Positioned SignInGoogle() {
    return Positioned(
        bottom: Get.height * 0.09,
        right: 30,
        left: 30,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColorFile.whiteColor,
                side: const BorderSide(color: Colors.deepOrange),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: signInWithGoogle,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/google.png',
                  height: Get.height * 0.07,
                  width: Get.width * 0.07,
                ),
                SizedBox(
                  width: 70,
                ),
                Text(
                  'Sign In With Google',
                  style: TextFile.header1TextStyle(),
                ),
              ],
            )));
  }

  Material InputFeildSection(Size size, BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Sign In',
              style:
                  TextFile.headerTextStyle().copyWith(color: Colors.deepOrange),
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: isVisible,
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: toggleVisibility,
                          icon: Icon(isVisible
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Valid pass';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorFile.primaryColor),
                      onPressed: formValidation,
                      child: Text(
                        'Login',
                        style: TextFile.header1TextStyle()
                            .copyWith(color: ColorFile.whiteColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                          style: TextFile.header3LightText()),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Text(
                          'SignUp',
                          style: TextFile.header3Text()
                              .copyWith(color: ColorFile.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void formValidation() {
    if (_key.currentState!.validate()) {
      onTabSignIn();
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      if (user == null) {
        SnackBarFile.showSnackBar(
            'Sign In Cancelled', 'User cancelled the Google sign-in.');
        return;
      }
      final GoogleSignInAuthentication auth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      SnackBarFile.showSnackBar('Success', 'Google Sign-In Successful!');
      Get.to(() =>  GoogleMapsAssignment());
    } catch (e) {
      SnackBarFile.showSnackBar('Google Sign-In Failed', e.toString());
    }
  }

  Future<void> onTabSignIn() async {
    isLoading = true;
    setState(() {});
    try {
      final value = await firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(), password: _passController.text);
      SnackBarFile.showSnackBar('Success', 'User Sign In${value.user!.email}');
      Get.to(() =>  GoogleMapsAssignment());
    } catch (e) {
      SnackBarFile.showSnackBar('Sign In Failed', (e.toString()));
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}
