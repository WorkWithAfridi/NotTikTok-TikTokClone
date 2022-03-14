import 'package:flutter/material.dart';
import 'package:not_tiktok/views/addVideoScreen.dart';
import 'package:not_tiktok/views/videoScreen.dart';

List homeScreenPages = [
  VideoScreen(),
  Container(
    alignment: Alignment.center,
    child: Text('Search'),
  ),
  AddVideoScreen(),
  Container(
    alignment: Alignment.center,
    child: Text('Messages'),
  ),
  Container(
    alignment: Alignment.center,
    child: Text('Profile'),
  ),
];
