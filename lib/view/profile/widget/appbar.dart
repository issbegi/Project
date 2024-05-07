import 'package:flutter/material.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';



PreferredSize? customAppBarProfile() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: SafeArea(
      child: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, 
        title: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
          ),
          child: Text(
            "My Profile",
            style: AppThemes.profileAppBarTitle,
          ),
        ),
        actions: const [

        ],
      ),
    ),
  );
}
