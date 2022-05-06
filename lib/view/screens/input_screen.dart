import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gridapp/app_constants/constants.dart';
import 'package:gridapp/controllers/input_details_controller.dart';
import 'package:gridapp/utils/gesture_detector_util.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/utils/snackbar_util.dart';
import 'package:gridapp/view/screens/grid_view_screen.dart';
import 'package:gridapp/view/widgets/custom_form_field.dart';
import 'package:gridapp/view/widgets/primary_button.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final InputDetailsController inputDetailsController =
      Get.find<InputDetailsController>();

  final _formKey = GlobalKey<FormState>();

  DateTime _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          GestureDetectorUtil.onScreenTap();
        },
        child: Scaffold(
          backgroundColor: Constant.white,
          appBar: AppBar(
            title: const Text('Enter Details'),
            centerTitle: true,
            backgroundColor: Constant.primaryColor,
            elevation: 0,
          ),
          bottomNavigationBar: _continueButton(),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Obx(
                () => Column(
                  children: [
                    CustomFormField(
                      maxLength: 3,
                      initialValue: inputDetailsController
                              .numberOfColumns.value.isNotEmpty
                          ? inputDetailsController.numberOfColumns.value
                          : null,
                      label: 'Columns*',
                      hintText: 'Enter number of columns',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        inputDetailsController.numberOfColumns.value =
                            value.trim();
                      },
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.h),
                    CustomFormField(
                      maxLength: 3,
                      initialValue:
                          inputDetailsController.numberOfRows.value.isNotEmpty
                              ? inputDetailsController.numberOfRows.value
                              : null,
                      label: 'Rows*',
                      hintText: 'Enter number of rows',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        inputDetailsController.numberOfRows.value =
                            value.trim();
                      },
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.h),
                    CustomFormField(
                      showCounter: true,
                      initialValue:
                          inputDetailsController.letters.value.trim().isNotEmpty
                              ? inputDetailsController.letters.value
                              : null,
                      label: 'Alphabets*',
                      hintText:
                          'Enter ${int.parse(inputDetailsController.numberOfColumns.value.isEmpty ? '1' : inputDetailsController.numberOfColumns.value) * int.parse(inputDetailsController.numberOfRows.value.isEmpty ? '1' : inputDetailsController.numberOfRows.value)} letters',
                      maxLines: 4,
                      maxLength: int.parse(inputDetailsController
                                  .numberOfColumns.value.isEmpty
                              ? '1'
                              : inputDetailsController.numberOfColumns.value) *
                          int.parse(
                              inputDetailsController.numberOfRows.value.isEmpty
                                  ? '1'
                                  : inputDetailsController.numberOfRows.value),
                      textInputAction: TextInputAction.newline,
                      onChanged: (String value) {
                        inputDetailsController.letters.value = value.trim();
                      },
                      inputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                      ],
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Enter ${int.parse(inputDetailsController.numberOfColumns.value.isEmpty ? '1' : inputDetailsController.numberOfColumns.value) * int.parse(inputDetailsController.numberOfRows.value.isEmpty ? '1' : inputDetailsController.numberOfRows.value)} letters';
                        } else if (value.trim().length <
                            int.parse(inputDetailsController
                                        .numberOfColumns.value.isEmpty
                                    ? '1'
                                    : inputDetailsController
                                        .numberOfColumns.value) *
                                int.parse(inputDetailsController
                                        .numberOfRows.value.isEmpty
                                    ? '1'
                                    : inputDetailsController
                                        .numberOfRows.value)) {
                          return 'Enter ${int.parse(inputDetailsController.numberOfColumns.value.isEmpty ? '1' : inputDetailsController.numberOfColumns.value) * int.parse(inputDetailsController.numberOfRows.value.isEmpty ? '1' : inputDetailsController.numberOfRows.value)} letters';
                        } else if (value.trim().length >
                            int.parse(inputDetailsController
                                        .numberOfColumns.value.isEmpty
                                    ? '1'
                                    : inputDetailsController
                                        .numberOfColumns.value) *
                                int.parse(inputDetailsController
                                        .numberOfRows.value.isEmpty
                                    ? '1'
                                    : inputDetailsController
                                        .numberOfRows.value)) {
                          return 'Enter only ${int.parse(inputDetailsController.numberOfColumns.value.isEmpty ? '1' : inputDetailsController.numberOfColumns.value) * int.parse(inputDetailsController.numberOfRows.value.isEmpty ? '1' : inputDetailsController.numberOfRows.value)} letters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: PrimaryButton(
        title: 'Continue',
        onPress: _validateDetails,
      ),
    );
  }

  void _validateDetails() {
    FocusManager.instance.primaryFocus.unfocus();

    if (!_formKey.currentState.validate()) {
      return;
    }

    _navigateToGridViewScreen();
  }

  void _navigateToGridViewScreen() {
    Get.to(() => const GridViewScreen());
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;

      SnackBarUtil.showSnackBar('Press back again to exit');

      return Future.value(false);
    }
    return Future.value(true);
  }
}
