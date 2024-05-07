// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:urbanfootprint/view/checkout/keys.dart';
import 'package:urbanfootprint/firebase_options.dart';
import 'package:urbanfootprint/view/home/auth_repo.dart';
import 'package:urbanfootprint/view/intropages/splashscreen.dart';




Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  MpesaFlutterPlugin.setConsumerKey(mConsumerkeys);
  MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthRepo());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      title: 'Urbanfootprint',
      home: SplashScreen(),
      
    );
  }
}
