
import 'package:flutter/material.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';
import 'package:urbanfootprint/utils/constants.dart';

PreferredSize? customAppBarDe(ctx) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text("Nike", style: AppThemes.detailsAppBar),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(ctx);
        },
        icon: Icon(
          Icons.arrow_back,
          color: AppConstantsColor.darkTextColor,
        ),
      ),
     
    ),
  );
}
