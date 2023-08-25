import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gridapp/app_constants/constants.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/view/screens/input_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.primaryColor,
      body: Center(
        child: Text(
          'GRID GAME',
          style: TextStyle(
              color: Constant.textWhite, fontSize: 4.t, letterSpacing: 3),
        ),
      ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.offAll(() => const InputScreen());
    });
  }
}
