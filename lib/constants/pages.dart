import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/views/addVideoScreen.dart';
import 'package:not_tiktok/views/profileScreen.dart';
import 'package:not_tiktok/views/searchScreen.dart';
import 'package:not_tiktok/views/homescreen.dart';

List homeScreenPages = [
  HomeScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Container(
    alignment: Alignment.center,
    child: Text('Messages - Work in Progress', style: subHeaderNotHighlightedTextStyle,),
  ),
  ProfileScreen(uid: authController.user.uid)
];
