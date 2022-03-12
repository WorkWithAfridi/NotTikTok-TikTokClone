import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String username;
  late String profilePictureUrl;
  late String email;
  late String uid;

  UserModel({
    required this.username,
    required this.profilePictureUrl,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'profilePhotoUrl': profilePictureUrl,
        'email': email,
        'uid': uid
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      profilePictureUrl: snapshot['profilePictureUrl'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
