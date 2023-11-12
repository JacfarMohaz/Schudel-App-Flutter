// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:production_schedule/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var username=prefs.getString("username");
  // print("username is nool $username");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: username==null?const LoginScreen():const home(),
  ));
}

class ProductionSchedule extends StatelessWidget {
  const ProductionSchedule({super.key,required this.username});

   final String username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home:username==null?const LoginScreen():const home(),
    );
  }
}
