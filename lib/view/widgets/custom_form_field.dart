import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridapp/app_constants/constants.dart';
import 'package:gridapp/utils/size_config.dart';
import 'package:gridapp/utils/style_utils.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Function onChanged;
  final Function? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatter;
  final bool showCounter;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.hintText,
    this.maxLines,
    this.textInputAction,
    required this.onChanged,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.maxLength,
    this.inputFormatter,
    this.showCounter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 1.8.t,
          ),
        ),
        SizedBox(height: 0.5.h),
        TextFormField(
          initialValue: initialValue,
          cursorColor: Constant.black,
          maxLines: maxLines,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          maxLength: maxLength,
          inputFormatters: inputFormatter,
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  (4 * kToolbarHeight)),
          decoration: InputDecoration(
            errorStyle: const TextStyle(height: 0.5, color: Colors.red),
            counterText: showCounter ? null : '',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Constant.grey400,
              fontSize: 1.8.t,
            ),
            fillColor: Constant.white,
            filled: true,
            focusedBorder: StyleUtil.formTextFieldInputBorder(),
            enabledBorder: StyleUtil.formTextFieldInputBorder(),
            border: StyleUtil.formTextFieldInputBorder(),
            errorBorder: StyleUtil.formTextFieldInputBorder(),
            disabledBorder: StyleUtil.formTextFieldInputBorder(),
          ),
          onChanged: (String value) {
            onChanged(value);
          },
          validator: validator == null
              ? null
              : (value) {
                  return validator!(value);
                },
        ),
      ],
    );
  }
}
