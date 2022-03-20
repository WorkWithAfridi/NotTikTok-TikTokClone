import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/views/auth/LoginScreen.dart';
import 'package:not_tiktok/views/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void triggerSplashScreen(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 3300));
    Get.to(()=> SplashScreenPush());
  }

  @override
  void initState() {
    triggerSplashScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: getHeight(context),
            width: getWidth(context),
            child: Image.asset(
              'assets/backdropOne.png',
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
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 80,
                  child: Lottie.asset(
                      'assets/lottieAnimations/logoLottieAnimation.json',
                      fit: BoxFit.fitHeight,
                      repeat: false),
                ),
                Container(
                  width: 1,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    gradient: LinearGradient(
                        colors: [
                          primary.withOpacity(.8),
                          Colors.red.withOpacity(.8),
                          Colors.redAccent.withOpacity(.8),
                          secondary.withOpacity(.8),
                          //add more colors for gradient
                        ],
                        begin: Alignment.topLeft, //begin of the gradient color
                        end: Alignment.bottomRight, //end of the gradient color
                        stops: const [0, 0.2, 0.5, 0.8] //stops for individual color
                        //set the stops number equal to numbers of color
                        ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '!TikTok',
                      style: AppTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'By KYOTO',
                      style: creatorTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreenPush extends StatelessWidget {
  const SplashScreenPush({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapsnot) {
        if (snapsnot.connectionState == ConnectionState.active) {
          if (snapsnot.hasData) {
            return HomeScreen();
          } else if (snapsnot.hasError) {
            return Center(
              child: Text('${snapsnot.error}'),
            );
          }
        }
        if (snapsnot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return LoginScreen();
      },
    );
  }
}
