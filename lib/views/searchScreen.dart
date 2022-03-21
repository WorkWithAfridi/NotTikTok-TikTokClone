import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/controller/searchController.dart';
import 'package:not_tiktok/model/userModel.dart';
import 'package:not_tiktok/views/profileScreen.dart';
import 'package:not_tiktok/widgets/customTextField.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTEC = TextEditingController();
  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary,
            title: getCustomTextFieldWithoutIcon(
                textEditingController: searchTEC,
                hintText: 'Search',
                textInputType: TextInputType.text,
                maxLines: 1),
            actions: [
              IconButton(
                onPressed: () {
                  if (searchTEC.text.isNotEmpty) {
                    searchController.searchUser(searchTEC.text);
                  }
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: Container(
            height: getHeight(context),
            width: getWidth(context),
            child: searchController.getSearchedUsers.isEmpty
                ? Center(
                    child: Container(
                      height: 50,
                      width: getWidth(context)*.6,
                      child: Image.asset('assets/searchForAUser.png'),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchController.getSearchedUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user = searchController.getSearchedUsers[index];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            ProfileScreen(uid: user.uid),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(user.profilePictureUrl),
                          ),
                          title: Text(user.username),
                        ),
                      );
                    },
                  ),
            // child:
          ),
        );
      },
    );
  }
}
