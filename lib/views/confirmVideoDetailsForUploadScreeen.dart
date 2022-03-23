import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/controller/uploadVideoController.dart';
import 'package:not_tiktok/widgets/customTextField.dart';
import 'package:video_player/video_player.dart';

import '../constants/customColors.dart';
import '../constants/textStyles.dart';

class AddVideoDetailsAndUploadScreen extends StatefulWidget {
  final XFile file;
  const AddVideoDetailsAndUploadScreen({Key? key, required this.file})
      : super(key: key);

  @override
  State<AddVideoDetailsAndUploadScreen> createState() =>
      _AddVideoDetailsAndUploadScreenState();
}

class _AddVideoDetailsAndUploadScreenState
    extends State<AddVideoDetailsAndUploadScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController =
          VideoPlayerController.file(File(widget.file.path));
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(.5);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: getHeight(context) / 1.5,
                width: getWidth(context),
                child: VideoPlayer(videoPlayerController),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: getWidth(context) - 20,
                        child: getCustomTextFieldWithIcon(
                          textEditingController: songController,
                          labelText: 'Enter sound track',
                          icon: Icons.music_note_rounded,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: getWidth(context) - 20,
                        child: getCustomTextFieldWithoutIcon(
                          textEditingController: captionController,
                          hintText: 'Enter a caption',
                          textInputType: TextInputType.text,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          uploadVideoController.uploadVideo(songController.text,
                              captionController.text, widget.file.path);
                        },
                        child: Container(
                          height: 40,
                          width: getWidth(context),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Share',
                            style: subHeaderTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
