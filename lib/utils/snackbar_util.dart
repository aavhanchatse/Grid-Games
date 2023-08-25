import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gridapp/app_constants/constants.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/utils/style_utils.dart';

class SnackBarUtil {
  static showSnackBar(String text, {Widget? actionButton, Color? color}) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(milliseconds: 2000),
      borderRadius: 16.0,
      margin: EdgeInsets.all(4.w),
      boxShadows: StyleUtil.primaryShadowLight(),
      backgroundColor: color ?? Constant.primaryColor.withOpacity(0.5),
      animationDuration: const Duration(milliseconds: 500),
      mainButton: actionButton,
      messageText: Text(
        text,
        style: TextStyle(
          color: color != null ? Constant.textColor : Constant.textWhite,
        ),
      ),
    ));
  }
}
