import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/customTextStyles.dart';
import 'package:not_tiktok/views/auth/SignupScreen.dart';
import 'package:not_tiktok/widgets/customTextField.dart';

import '../../constants/customColors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'NotTikTok',
              style: appNameTextStyle,
            ),
            Text(
              'Login',
              style: defaultTextStyle,
            ),
            SizedBox(
              height: 30,
            ),
            getCustomTextField(
                textEditingController: emailTEC,
                hintText: 'Enter email',
                textInputType: TextInputType.emailAddress,
                maxLines: 1),
            SizedBox(
              height: 10,
            ),
            getCustomTextField(
              textEditingController: passwordTEC,
              hintText: 'Enter ppassword',
              textInputType: TextInputType.text,
              maxLines: 1,
              isPass: true,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                authController.loginUser(emailTEC.text, passwordTEC.text);
              },
              child: Container(
                color: primary,
                height: 50,
                width: getWidth(context),
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: defaultTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(SignupScreen());
              },
              child: Container(
                color: primary,
                height: 50,
                width: getWidth(context),
                alignment: Alignment.center,
                child: Text(
                  'Signup',
                  style: defaultTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
