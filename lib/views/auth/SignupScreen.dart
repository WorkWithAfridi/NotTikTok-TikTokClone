import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/customTextStyles.dart';
import 'package:not_tiktok/controller/auth_controller.dart';
import 'package:not_tiktok/widgets/customTextField.dart';

import '../../constants/customColors.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController usernameTEC = TextEditingController();
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
              'signup',
              style: defaultTextStyle,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: getWidth(context),
              height: 100,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: background,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1646936218493-d206c6284291?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        authController.pickImage();
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            getCustomTextField(
                textEditingController: usernameTEC,
                hintText: 'Enter username',
                textInputType: TextInputType.emailAddress,
                maxLines: 1),
            SizedBox(
              height: 10,
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
              onTap: ()=> authController.registerUser(usernameTEC.text, emailTEC.text, passwordTEC.text, authController.getPickedImage),
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
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: primary,
                height: 50,
                width: getWidth(context),
                alignment: Alignment.center,
                child: Text(
                  'login',
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
