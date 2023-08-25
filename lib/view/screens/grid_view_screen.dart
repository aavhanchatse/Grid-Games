import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gridapp/app_constants/constants.dart';
import 'package:gridapp/controllers/input_details_controller.dart';
import 'package:gridapp/utils/gesture_detector_util.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/utils/style_utils.dart';
import 'package:gridapp/view/widgets/custom_form_field.dart';
import 'package:gridapp/view/widgets/primary_button.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({Key? key}) : super(key: key);

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  final InputDetailsController inputDetailsController =
      Get.find<InputDetailsController>();

  List<String> _charList = [];
  List<String> _inputString = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GestureDetectorUtil.onScreenTap();
      },
      child: Scaffold(
        backgroundColor: Constant.white,
        appBar: AppBar(
          title: const Text('Grid Game'),
          centerTitle: true,
          backgroundColor: Constant.primaryColor,
          elevation: 0,
        ),
        bottomNavigationBar: _resetButton(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: CustomFormField(
                label: 'Word',
                hintText: 'Enter word to find',
                textInputAction: TextInputAction.next,
                onChanged: (String value) {
                  _updateInputCharList(value.toUpperCase());
                  setState(() {});
                },
                inputFormatter: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                ],
              ),
            ),
            Obx(
              () => Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        int.parse(inputDetailsController.numberOfColumns.value),
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: _charList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4.w),
                  itemBuilder: (BuildContext context, int index) {
                    String char = _charList[index];
                    return _gridItem(char);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateInputCharList(String value) {
    final result = value.split('');
    // debugPrint(result.toString());
    _inputString = result;
    setState(() {});
  }

  Widget _gridItem(String char) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _inputString.contains(char.toUpperCase())
            ? Constant.primaryColor.withOpacity(0.6)
            : Constant.primaryColor.withOpacity(0.1),
        boxShadow: StyleUtil.primaryShadowLight(),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          char.toUpperCase(),
          style: TextStyle(
            color: _inputString.contains(char.toUpperCase())
                ? Constant.textWhite
                : Constant.textColor,
          ),
        ),
      ),
    );
  }

  void _getCharacters() {
    List<String> result = inputDetailsController.letters.value.split('');
    // debugPrint('result: $result');
    _charList = result;
    setState(() {});
  }

  Widget _resetButton() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: PrimaryButton(
        title: 'Reset',
        onPress: () {
          Get.back();
        },
      ),
    );
  }
}
