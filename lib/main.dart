import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gridapp/controllers/input_details_controller.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/view/screens/splash_screen.dart';

void main() {
  if (kReleaseMode) {
    debugPrint = (String message, {int wrapWidth}) {};
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(InputDetailsController());

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return OrientationBuilder(
          builder: (BuildContext context2, Orientation orientation) {
        SizeConfig.init(constraints, orientation);

        return GetMaterialApp(
          title: "GridApp",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          defaultTransition:
              GetPlatform.isIOS ? Transition.cupertino : Transition.rightToLeft,
          home: const SplashScreen(),
        );
      });
    });
  }
}
