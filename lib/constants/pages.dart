import 'package:flutter/material.dart';
import 'package:not_tiktok/views/addVideoScreen.dart';

List homeScreenPages = [
  Container(
    alignment: Alignment.center,
    child: Text('Home'),
  ),
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
