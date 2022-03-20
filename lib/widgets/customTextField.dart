import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/textStyles.dart';

class getCustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final IconData icon;
  final bool isObscure;

  const getCustomTextField(
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
