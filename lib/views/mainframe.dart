import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/pages.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/widgets/customIcons.dart';

import 'confirmVideoDetailsForUploadScreeen.dart';

class Mainframe extends StatefulWidget {
  const Mainframe({Key? key}) : super(key: key);

  @override
  State<Mainframe> createState() => _MainframeState();
}

class _MainframeState extends State<Mainframe> {
  int pageIndex = 0;
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src,);
    print('video chose');
    if (video != null) {
      print('pushing video');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddVideoDetailsAndUploadScreen(
            file: video,
          ),
        ),
      );
    } else {
      Get.back();
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.black,
        elevation: 6,
        alignment: Alignment.center,
        title: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => OpenWebView(
            //         websiteLink:
            //         'https://sites.google.com/view/workwithafridi'),
            //   ),
            // );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '!TikTok',
                style: headerTextStyle,
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
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.camera, context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.camera,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Text(
                    'Camera',
                    style: subHeaderTextStyle,
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.gallery, context);
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Text(
                    'Gallery',
                    style: subHeaderTextStyle,
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.cancel,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Text(
                    'Cancel',
                    style: subHeaderTextStyle,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenPages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primary,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: pageIndex,
        onTap: (index) {
          if (index == 2) {
            showOptionsDialog(context);
          } else {
            setState(() {
              pageIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search'),
          BottomNavigationBarItem(icon: CustomAddIcon(), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 30,
              ),
              label: 'Message'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
