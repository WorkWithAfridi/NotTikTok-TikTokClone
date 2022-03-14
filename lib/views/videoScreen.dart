import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/controller/videoController.dart';
import 'package:not_tiktok/widgets/videoPlayerItem.dart';

import '../widgets/circleAnimation.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhotoUrl) {
    return SizedBox(
      width: 60,
      height: 60,
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
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
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
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Container(
                  height: getHeight(context),
                  width: getWidth(context),
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.yellow,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                        SizedBox(
                                          height: 35,
                                        )
                                      ]),
                                ),
                              ),
                              Container(
                                // height: 800,
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    top: getHeight(context) / 3),
                                padding: EdgeInsets.only(right: 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildProfile(data.profilePhotoUrl),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () =>videoController.likeVideo(data.vid),
                                          child: Icon(
                                            Icons.favorite,
                                            color: data.likes.contains(authController.user.uid) ? Colors.red : Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                            '${data.likes.length.toString()}'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.comment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(data.commentCount.toString()),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.reply,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(data.shareCount.toString()),
                                      ],
                                    ),
                                    CircleAnimation(
                                      child:
                                          buildMusicAlbum(data.profilePhotoUrl),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
