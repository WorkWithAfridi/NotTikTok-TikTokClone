import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then(
        (value) {
          controller.play();
          controller.setVolume(.5);
        },
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context),
      width: getWidth(context),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(
        controller,
      ),
    );
  }
}
