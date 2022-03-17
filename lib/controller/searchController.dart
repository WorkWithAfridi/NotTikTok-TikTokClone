import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/firebase.dart';
import 'package:not_tiktok/model/userModel.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUsers = Rx<List<UserModel>>([]);
  List<UserModel> get getSearchedUsers => _searchedUsers.value;
  searchUser(String typedUser)async {
    _searchedUsers.bindStream(
      firestore
          .collection('users')
          .where('username', isEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          List<UserModel> returnValue = [];
          for (var element in snapshot.docs) {
            returnValue.add(UserModel.fromSnap(element));
          }
          return returnValue;
        },
      ),
    );
  }
}
