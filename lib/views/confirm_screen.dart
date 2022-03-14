import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/controller/uploadVideoController.dart';
import 'package:not_tiktok/widgets/customTextField.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File video;
  final String videoPath;
  const ConfirmScreen({Key? key, required this.video, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
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
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: getWidth(context) - 20,
                      child: getCustomTextField(
                        textEditingController: songController,
                        hintText: 'Song name',
                        textInputType: TextInputType.text,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: getWidth(context) - 20,
                      child: getCustomTextField(
                        textEditingController: captionController,
                        hintText: 'Caption',
                        textInputType: TextInputType.text,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          uploadVideoController.uploadVideo(songController.text,
                              captionController.text, widget.videoPath);
                        },
                        child: Text('Share'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
