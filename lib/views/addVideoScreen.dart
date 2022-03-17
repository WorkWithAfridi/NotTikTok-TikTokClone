import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/views/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoPath: video.path,
            video: File(video.path),
          ),
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.camera, context);
            },
            child: Row(
              children: const [
                Icon(Icons.camera),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Camera',
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
                Icon(Icons.image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gallery',
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
                Icon(Icons.cancel),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cancel',
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
      body: Center(
        child: InkWell(
          onTap: () {
            showOptionsDialog(context);
          },
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(color: primary),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => showOptionsDialog(context),
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
