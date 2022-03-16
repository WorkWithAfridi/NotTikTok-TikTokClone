import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/firebase.dart';
import 'package:not_tiktok/model/commentModel.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _listOfComments = Rx<List<CommentModel>>([]);

  List<CommentModel> get listOfComments => _listOfComments.value;
  String _postId = '';
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _listOfComments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map(
      (QuerySnapshot querySnapshot) {
        List<CommentModel> retVal = [];
        for (var element in querySnapshot.docs) {
          retVal.add(CommentModel.fromSnap(element));
        }
        return retVal;
      },
    ));
  }

  postComment(String commentText) async {
    if (commentText.isNotEmpty) {
      DocumentSnapshot userDocument = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .get();
      var allDocments = await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .get();
      int len = allDocments.docs.length;
      print(len);
      CommentModel commentModel = CommentModel(
          username: (userDocument.data()! as dynamic)['username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          profilePhotoUrl: (userDocument.data()! as dynamic)['profilePhotoUrl'],
          uid: authController.user.uid,
          likes: [],
          id: 'Comment $len');

      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc('Comment $len')
          .set(
            commentModel.toJson(),
          );
      DocumentSnapshot snapshot =
          await firestore.collection('videos').doc(_postId).get();
      await firestore.collection('videos').doc(_postId).update({
        'commentCount': (snapshot.data()! as dynamic)['commentCount'] + 1,
      });
    } else {
      Get.snackbar('Error', 'Input empty.');
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot documentSnapshot = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((documentSnapshot.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
