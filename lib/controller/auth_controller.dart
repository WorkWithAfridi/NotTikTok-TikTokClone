import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_tiktok/constants/firebase.dart';
import 'package:not_tiktok/model/userModel.dart';
import 'package:not_tiktok/views/auth/LoginScreen.dart';
import 'package:not_tiktok/views/homeScreen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  /// a get x function, runs after 1 frame of on Init
  @override
  void onReady() async {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    // await Future.delayed(Duration(seconds: 1));
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  //upload to firebase storage
  Future<String> uploadToFirebaseStorgae(File image) async {
    Reference ref = firebaseStorgae
        .ref()
        .child('profilePictrues')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  late Rx<File?> _pickedImage;

  File? get getPickedImage => _pickedImage.value;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          'Image picked', 'A profile picture has been picked from gallery');

      _pickedImage = Rx<File?>(File(pickedImage.path));
    } else {
      Get.snackbar(
          'Please choose an Image', 'Profile picture has not yet been picked');
    }
  }

  //registerUser
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String profilePictureImageUrl = await uploadToFirebaseStorgae(image);
        UserModel userModel = UserModel(
            username: username,
            profilePictureUrl: profilePictureImageUrl,
            email: email,
            uid: userCredential.user!.uid);
        firestore.collection('users').doc(userCredential.user!.uid).set(
              userModel.toJson(),
            );
        Get.snackbar('Hi', 'Your NotTikTok profile has been created');
      } else {
        Get.snackbar('Error', 'Fields cannot be empty');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Error creating a user');
    }
  }

  //login user
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('success-login');
      } else {
        Get.snackbar('Error', 'Login credentials cannot be empty.');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'An error occurred, please try again.');
    }
  }
}
