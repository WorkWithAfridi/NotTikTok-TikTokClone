import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/controller/auth_controller.dart';
import 'package:not_tiktok/views/homeScreen.dart';
import 'package:not_tiktok/widgets/customTextField.dart';

import '../../constants/customColors.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameTEC = TextEditingController();

  TextEditingController emailTEC = TextEditingController();

  TextEditingController passwordTEC = TextEditingController();

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: Stack(
          children: [
            SizedBox(
              height: getHeight(context),
              width: getWidth(context),
              child: Image.asset(
                'assets/backDropThree.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: getHeight(context),
              width: getWidth(context),
              color: Colors.black.withOpacity(.75),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    Text('NotTikTok', style: AppTitleTextStyle),
                    Text(
                      "It's !instagram and it's better.",
                      style: subHeaderNotHighlightedTextStyle.copyWith(
                          height: .8, fontSize: 13),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // width: getWidth(context),
                      // height: 100,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              _image == null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundColor: background,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(64),
                                          child: Image.asset(
                                              'assets/defaultProfileImage.png')),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: () async {
                                    Uint8List? image = await authController
                                        .pickImage(ImageSource.gallery);

                                    if (image != null) {
                                      setState(() {
                                        _image = image;
                                      });
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Create a \nnew account',
                            style: AppTitleTextStyle.copyWith(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    getCustomTextField(
                        textEditingController: usernameTEC,
                        labelText: 'Enter username',
                        icon: Icons.person),
                    SizedBox(
                      height: 15,
                    ),
                    getCustomTextField(
                        textEditingController: emailTEC,
                        labelText: 'Enter email',
                        icon: Icons.mail),
                    SizedBox(
                      height: 15,
                    ),
                    getCustomTextField(
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
                        if (usernameTEC.text.isNotEmpty &&
                            passwordTEC.text.isNotEmpty &&
                            emailTEC.text.isNotEmpty &&
                            _image != null) {
                          authController.registerUser(usernameTEC.text,
                              emailTEC.text, passwordTEC.text, _image!);
                        } else {
                          Get.snackbar('Invalid input',
                              'User credentials cannot be empty!', margin: EdgeInsets.only(top: 15, left: 5, right: 5 ));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: getWidth(context),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Signup',
                          style: subHeaderTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Already have an account? ",
                      style: subHeaderNotHighlightedTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Login',
                        style: subHeaderTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 125,
              width: getWidth(context),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
