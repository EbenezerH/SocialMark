import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/theme/theme.dart';
import 'package:mark_soc/screens/views/introduction_page.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.init("SocialMark");
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: secondColor),
        useMaterial3: true,
      ),
      home: const IntroductionPage(),
    );
  }
}
