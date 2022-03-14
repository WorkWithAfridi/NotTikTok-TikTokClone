import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/authControllerConstant.dart';
import 'package:not_tiktok/constants/firebase.dart';
import 'package:not_tiktok/model/videoModel.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);

  List<VideoModel> get videoList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(
      firestore.collection('videos').snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<VideoModel> returnValue = [];
          for (var element in querySnapshot.docs) {
            returnValue.add(
              VideoModel.fromSnap(element),
            );
          }
          return returnValue;
        },
      ),
    );
  }

  likeVideo(String id) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((documentSnapshot.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayRemove([uid])
        },
      );
    }else{
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayUnion([uid])
        },
      );
    }
  }
}
