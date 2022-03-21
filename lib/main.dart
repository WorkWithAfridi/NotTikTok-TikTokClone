import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/views/auth/SignupScreen.dart';
import 'package:not_tiktok/views/mainframe.dart';
import 'package:not_tiktok/views/splashScreen.dart';

import 'controller/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const NotTikTokApp());
}

class NotTikTokApp extends StatelessWidget {
  const NotTikTokApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(primaryColor: primary, scaffoldBackgroundColor: background),
      home:SplashScreen(),
    );
  }
}

//done till 2:59:00