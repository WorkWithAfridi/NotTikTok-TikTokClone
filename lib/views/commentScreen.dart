import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/controller/commentController.dart';
import 'package:not_tiktok/widgets/customTextField.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);

  CommentController commentController = Get.put(CommentController());

  TextEditingController commentTECController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: background,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // color: Colors.pink,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final comment =
                                commentController.listOfComments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: background,
                                backgroundImage:
                                    NetworkImage(comment.profilePhotoUrl),
                              ),
                              title: Row(
                                children: [
                                  Text(comment.username),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(comment.comment),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(timeago
                                      .format(comment.datePublished.toDate())),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('${comment.likes.length} likes'),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  commentController.likeComment(comment.id);
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: comment.likes
                                          .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            );
                          },
                          itemCount: commentController.listOfComments.length,
                        );
                      }),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 65,
              width: getWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 15),
              // color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: getCustomTextField(
                      textEditingController: commentTECController,
                      hintText: 'Comment',
                      maxLines: 1,
                      textInputType: TextInputType.text,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      commentController.postComment(commentTECController.text);
                    },
                    child: Text(
                      "SEND",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
