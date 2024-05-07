import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';


PreferredSize? customAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false, // Remove the back arrow
     title: Text(
        "Discover",
        style: AppThemes.homeAppBar,
      ),
      actions: [

      ],
    ),
  );
}
