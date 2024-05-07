import 'package:flutter/material.dart';
import 'package:urbanfootprint/utils/constants.dart';
import 'package:urbanfootprint/view/bag/widget/body.dart';

class MyBagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        body: BodyBagView(),
      ),
    );
  }
}
