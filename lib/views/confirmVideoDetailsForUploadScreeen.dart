import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/controller/uploadVideoController.dart';
import 'package:not_tiktok/widgets/customTextField.dart';
import 'package:video_player/video_player.dart';

import '../constants/customColors.dart';
import '../constants/textStyles.dart';

class ConfirmVideoDetailsForUploadScreen extends StatefulWidget {
  final File video;
  final String videoPath;
  const ConfirmVideoDetailsForUploadScreen(
      {Key? key, required this.video, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmVideoDetailsForUploadScreen> createState() =>
      _ConfirmVideoDetailsForUploadScreenState();
}

class _ConfirmVideoDetailsForUploadScreenState
    extends State<ConfirmVideoDetailsForUploadScreen> {
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
      videoPlayerController = VideoPlayerController.file(widget.video);
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
                              captionController.text, widget.videoPath);
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
