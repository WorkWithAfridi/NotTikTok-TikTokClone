import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/customTextStyles.dart';

class getCustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final int maxLines;

  const getCustomTextField(
      {Key? key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType, required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(

      style: defaultTextStyle,
      cursorColor: Colors.white54,
      controller: textEditingController,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: defaultTextStyle,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        fillColor: Colors.white10,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
