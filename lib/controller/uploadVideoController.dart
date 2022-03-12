import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/firebase.dart';
import 'package:not_tiktok/model/videoModel.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  //Compresses video
  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  //uploads video to storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorgae.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressedVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  //returns the thumbnail url;
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  //upload thumbnail image to storage
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorgae.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  //function to upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      //video id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('Video $len', videoPath);
      String thumbnailUrl =
          await _uploadImageToStorage('Video $len', videoPath);

      VideoModel video = VideoModel(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        vid: 'Video $len',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhotoUrl:
            (userDoc.data()! as Map<String, dynamic>)['profilePhotoUrl'],
        thumbnailUrl: thumbnailUrl,
      );

      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      print('success -------------------------------------------------- ');
      Get.back();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'An error occurred while uploading the video. :(');
    }
  }
}
