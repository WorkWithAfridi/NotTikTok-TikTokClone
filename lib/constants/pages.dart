import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/views/addVideoScreen.dart';
import 'package:not_tiktok/views/profileScreen.dart';
import 'package:not_tiktok/views/searchScreen.dart';
import 'package:not_tiktok/views/videoScreen.dart';

List homeScreenPages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Container(
    alignment: Alignment.center,
    child: Text('Messages'),
  ),
  ProfileScreen(uid: authController.user.uid)
];
