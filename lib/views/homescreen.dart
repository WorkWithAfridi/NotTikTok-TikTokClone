import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/controller/videoController.dart';
import 'package:not_tiktok/views/commentScreen.dart';
import 'package:not_tiktok/widgets/videoPlayerItem.dart';

import '../widgets/circleAnimation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhotoUrl) {
    return SizedBox(
      width: 60,
      height: 52,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhotoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary,
                  secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: getHeight(context),
            width: getWidth(context),
            padding: EdgeInsets.all(25),
            child: Image.asset('assets/!TikTok.png'),
          ),
          Obx(() {
            return Container(
              height: getHeight(context),
              width: getWidth(context),
              child: PageView.builder(
                itemCount: videoController.videoList.length,
                controller: PageController(initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final data = videoController.videoList[index];
                  return Stack(
                    children: [
                      VideoPlayerItem(videoUrl: data.videoUrl),
                      SizedBox(
                        // color: Colors.red,
                        height: getHeight(context), width: getWidth(context),

                        // color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          // color: Colors.red,
                          width: getWidth(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildProfile(data.profilePhotoUrl),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => videoController
                                              .likeVideo(data.vid),
                                          child: Icon(
                                            FontAwesomeIcons.solidHeart,
                                            color: data.likes.contains(
                                                    authController.user.uid)
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('${data.likes.length.toString()}'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen(
                                                  id: data.vid,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.solidComment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(data.commentCount.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            FontAwesomeIcons.share,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(data.shareCount.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    // color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.username,
                                        ),
                                        Text(
                                          data.caption,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.music_note,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              data.caption,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  CircleAnimation(
                                    child:
                                        buildMusicAlbum(data.profilePhotoUrl),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
