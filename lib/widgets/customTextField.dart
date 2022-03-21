import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/textStyles.dart';

class getCustomTextFieldWithIcon extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final IconData icon;
  final bool isObscure;

  const getCustomTextFieldWithIcon(
      {Key? key,
      required this.textEditingController,
      required this.labelText,
      this.isObscure = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        cursorColor: primary,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: primary,
          ),
          labelStyle: TextStyle(fontSize: 18, color: Colors.white60),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        obscureText: isObscure,
      ),
    );

    //   Container(
    //   height: 60,
    //   child: TextField(
    //     controller: textEditingController,
    //     style: headerTextStyle,
    //     cursorColor: Colors.white,
    //     // cursorHeight: 15,
    //     textAlign: TextAlign.start,
    //
    //     decoration: InputDecoration(
    //       label: Text(labelText, style: subHeaderTextStyle.copyWith(fontSize: 18),),
    //       prefix: Padding(
    //         padding: const EdgeInsets.only(right: 10.0),
    //         child: Icon(icon, size: 20,),
    //       ),
    //       labelStyle: headerTextStyle,
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: BorderSide(color: Colors.white)),
    //       focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: BorderSide(color: Colors.white)),
    //     ),
    //     obscureText: isObscure,
    //   ),
    // );
  }
}

class getCustomTextFieldWithoutIcon extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;
  final int maxLines;
  const getCustomTextFieldWithoutIcon({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.maxLines,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      style: subHeaderTextStyle.copyWith(fontSize: 16),
      cursorColor: Colors.white,
      controller: textEditingController,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: subHeaderNotHighlightedTextStyle.copyWith(fontSize: 15),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
