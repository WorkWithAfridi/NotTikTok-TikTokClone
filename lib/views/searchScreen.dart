import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
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
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: getCustomTextField(
            textEditingController: searchTEC,
            textInputType: TextInputType.text,
            maxLines: 1,
            hintText: 'Search',
          ),
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
                  child: Text('Search for user'),
                )
              : ListView.builder(
                  itemCount: searchController.getSearchedUsers.length,
                  itemBuilder: (context, index) {
                    UserModel user = searchController.getSearchedUsers[index];
                    return InkWell(
                      onTap: () {
                        Get.to(ProfileScreen(uid: user.uid),);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePictureUrl),
                        ),
                        title: Text(user.username),
                      ),
                    );
                  },
                ),
          // child:
        ),
      );
    });
  }
}
