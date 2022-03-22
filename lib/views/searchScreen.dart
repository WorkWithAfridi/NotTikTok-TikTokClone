import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:not_tiktok/constants/appData.dart';
import 'package:not_tiktok/constants/customColors.dart';
import 'package:not_tiktok/constants/textStyles.dart';
import 'package:not_tiktok/controller/searchController.dart';
import 'package:not_tiktok/model/userModel.dart';
import 'package:not_tiktok/views/profileScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class getCustomTextFieldWithIcon extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final IconData icon;
  final bool isObscure;

  const getCustomTextFieldWithIcon(
      {Key? key,
      required this.textEditingController,
      required this.labelText,
      this.isObscure = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.find<SearchController>();
    return Container(
      height: 50,
      child: TextField(
        cursorColor: primary,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          labelStyle: TextStyle(fontSize: 18, color: Colors.white60),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        obscureText: isObscure,
        onChanged: (value) {
          print(value);
          if (value.isNotEmpty) {
            print('seraching');
            searchController.searchUser(value);
          }
        },
      ),
    );

    //   Container(
    //   height: 60,
    //   child: TextField(
    //     controller: textEditingController,
    //     style: headerTextStyle,
    //     cursorColor: Colors.white,
    //     // cursorHeight: 15,
    //     textAlign: TextAlign.start,
    //
    //     decoration: InputDecoration(
    //       label: Text(labelText, style: subHeaderTextStyle.copyWith(fontSize: 18),),
    //       prefix: Padding(
    //         padding: const EdgeInsets.only(right: 10.0),
    //         child: Icon(icon, size: 20,),
    //       ),
    //       labelStyle: headerTextStyle,
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: BorderSide(color: Colors.white)),
    //       focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: BorderSide(color: Colors.white)),
    //     ),
    //     obscureText: isObscure,
    //   ),
    // );
  }
}

List<String> demoStories = [
  'https://images.unsplash.com/photo-1647793139802-8ff0b44dec6d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
  'https://images.unsplash.com/photo-1639784152398-5858d8c3e61f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
  'https://images.unsplash.com/photo-1639565770091-55e1de87e749?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1612085546117-01da93b3f8e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
  'https://images.unsplash.com/photo-1612085546117-01da93b3f8e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80'
];

List<String> demoUsers = [
  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
  'https://images.unsplash.com/photo-1605453302863-85c32f2adc76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1620794108219-aedbaded4eea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1620399909663-b7a7da934161?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1600070077692-d6c610986bfc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
];

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTEC = TextEditingController();
  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: getHeight(context),
            width: getWidth(context),
            child: Stack(
              children: [
                SizedBox(
                  height: getHeight(context),
                  width: getWidth(context),
                  child: Image.asset(
                    'assets/backDropFive.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: getHeight(context),
                  width: getWidth(context),
                  color: Colors.black.withOpacity(.75),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        title: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            getCustomTextFieldWithIcon(
                              textEditingController: searchTEC,
                              labelText: 'Search',
                              icon: FontAwesomeIcons.magnifyingGlass,
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              if (searchTEC.text.isNotEmpty) {
                                searchController.searchUser(searchTEC.text);
                              }
                            },
                            icon: Icon(FontAwesomeIcons.qrcode),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      searchController.getSearchedUsers.isEmpty
                          ? Container(
                              height: getHeight(context) + 100,
                              width: getWidth(context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      'Stories',
                                      style: headerTextStyle,
                                    ),
                                  ),
                                  Container(
                                    width: getWidth(context),
                                    height: getHeight(context) / 3,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        demoStories.shuffle();
                                        demoUsers.shuffle();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
                                                height: getHeight(context) / 3,
                                                width: getWidth(context) / 2.5,
                                                // color: Colors.purple,
                                                child: Image.network(
                                                  demoStories[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                // color:Colors.red,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 30.0),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            height: 90,
                                                            width: 90,
                                                            decoration: BoxDecoration(
                                                                color: primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90)),
                                                          ),
                                                          SizedBox(
                                                            height: 85,
                                                            width: 85,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          85),
                                                              child:
                                                                  Image.network(
                                                                demoUsers[index],
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 7,
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            alignment:
                                                                Alignment.center,
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        primary,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                20)),
                                                              ),
                                                              IconButton(
                                                                onPressed: () {},
                                                                icon: Icon(
                                                                  Icons.add,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      child: Text(
                                                        'User ${Random().nextInt(69) + index}',
                                                        style: subHeaderTextStyle,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      'Trending',
                                      style: headerTextStyle,
                                    ),
                                  ),
                                  Container(
                                    width: getWidth(context),
                                    height: getHeight(context) / 3.5,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        demoStories.shuffle();
                                        demoUsers.shuffle();
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                height: getHeight(context) / 3.5,
                                                width: getWidth(context) / 3.2,
                                                // color: Colors.purple,
                                                child: Image.network(
                                                  demoStories[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, bottom: 10),
                                                child: Text(
                                                  '${6 + index}.9M',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                          .withOpacity(.9)),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      '#Happy',
                                      style: headerTextStyle,
                                    ),
                                  ),
                                  Container(
                                    width: getWidth(context),
                                    height: getHeight(context) / 3.5,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        demoStories.shuffle();
                                        demoUsers.shuffle();
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                height: getHeight(context) / 3.5,
                                                width: getWidth(context) / 3.2,
                                                // color: Colors.purple,
                                                child: Image.network(
                                                  demoStories[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, bottom: 10),
                                                child: Text(
                                                  '${6 + index}.9M',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                          .withOpacity(.9)),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'Search results',
                                    style: headerTextStyle,
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      searchController.getSearchedUsers.length,
                                  itemBuilder: (context, index) {
                                    UserModel user =
                                        searchController.getSearchedUsers[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          ProfileScreen(uid: user.uid),
                                        );
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              user.profilePictureUrl),
                                        ),
                                        title: Text(user.username),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
            // child:
          ),
        ),
      );
    });
  }
}
