import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String vid;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String profilePhotoUrl;
  String thumbnailUrl;

  VideoModel({
    required this.username,
    required this.uid,
    required this.vid,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.profilePhotoUrl,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'vid': vid,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'profilePhotoUrl': profilePhotoUrl,
        'thumbnail': thumbnailUrl
      };

  static VideoModel fromSnap(DocumentSnapshot snapshot) {
    return VideoModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      vid: snapshot['vid'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      profilePhotoUrl: snapshot['profilePhotoUrl'],
      thumbnailUrl: snapshot['thumbnail'],
    );
  }
}
