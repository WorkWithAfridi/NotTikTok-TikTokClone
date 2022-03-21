import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/textStyles.dart';
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
      body: Stack(
        children: [
          SizedBox(
            height: getHeight(context),
            width: getWidth(context),
            child: Image.asset(
              'assets/backdropTwo.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: getHeight(context),
            width: getWidth(context),
            color: Colors.black.withOpacity(.75),
          ),
          Container(
            height: getHeight(context),
            width: getWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'NotTikTok',
                          style: AppTitleTextStyle.copyWith(fontSize: 30),
                        ),
                        Text(
                          'Its !TikTok and thats enough!',
                          style: subHeaderNotHighlightedTextStyle.copyWith(
                              height: .8, fontSize: 13),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        getCustomTextFieldWithIcon(
                            textEditingController: emailTEC,
                            labelText: 'Enter email',
                            icon: Icons.mail),
                        SizedBox(
                          height: 15,
                        ),
                        getCustomTextFieldWithIcon(
                          textEditingController: passwordTEC,
                          labelText: 'Enter password',
                          icon: Icons.password,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            authController.loginUser(
                                emailTEC.text, passwordTEC.text);
                          },
                          child: Container(
                            height: 40,
                            width: getWidth(context),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Login',
                              style: subHeaderTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Get.to(SignupScreen());
                        //   },
                        //   child: Container(
                        //     color: primary,
                        //     height: 50,
                        //     width: getWidth(context),
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       'Signup',
                        //       style: subHeaderTextStyle,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: subHeaderNotHighlightedTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: subHeaderTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
