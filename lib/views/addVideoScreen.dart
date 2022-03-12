import 'package:flutter/material.dart';
import 'package:not_tiktok/constants/customColors.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(color: primary),
            alignment: Alignment.center,
            child: Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
