import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String comment;
  final datePublished;
  String profilePhotoUrl;
  List likes;
  String uid;
  String id;

  CommentModel({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.profilePhotoUrl,
    required this.uid,
    required this.likes,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhotoUrl': profilePhotoUrl,
        'uid': uid,
        'id': id,
      };

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
        username: snapshot['username'],
        comment: snapshot["comment"],
        datePublished: snapshot['datePublished'],
        profilePhotoUrl: snapshot['profilePhotoUrl'],
        uid: snapshot['uid'],
        likes: snapshot['likes'],
        id: snapshot['id']);
  }
}
