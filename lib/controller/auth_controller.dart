import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
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
    // ever(_user, _setInitialScreen);
  }

  User get user => _user.value!;

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  //upload to firebase storage
  Future<String> uploadToFirebaseStorgae(Uint8List image) async {
    Reference ref = firebaseStorgae
        .ref()
        .child('profilePictrues')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // late Rx<File?> _pickedImage;
  Uint8List? _pickedImage = null;
  Uint8List? get getPickedImage => _pickedImage;

  // File? get getPickedImage => _pickedImage.value;

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      File? croppedImage = await ImageCropper().cropImage(
        sourcePath: _file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxHeight: 500,
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

      Uint8List? croppedAndCompressedImage =
          await FlutterImageCompress.compressWithFile(croppedImage!.path,
              quality: 10);
      _pickedImage = croppedAndCompressedImage;
      return croppedAndCompressedImage;
    }
    //
    // final pickedImage =
    //     await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedImage != null) {
    //   Get.snackbar(
    //       'Image picked', 'A profile picture has been picked from gallery');
    //
    //   _pickedImage = Rx<File?>(File(pickedImage.path));
    // } else {
    //   Get.snackbar(
    //       'Please choose an Image', 'Profile picture has not yet been picked');
    // }
  }

  //registerUser
  void registerUser(
      String username, String email, String password, Uint8List image) async {
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
        Get.offAll(() => HomeScreen());
        Get.snackbar('Hi, $username', 'Welcome to !TikTok! :)');
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

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
