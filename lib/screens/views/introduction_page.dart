import 'package:flutter/material.dart';
import '../../constant/constants.dart';
import '../../firebase/firebase_methodes.dart';
import '../../theme/theme.dart';
import 'loading_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  bool introPage_2 = false;

  @override
  void initState() {
    getAllStringValuesSF();
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        introPage_2 = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>  LoadingScreen(userId: theUid),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: firstColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Social Marketing"),
            ],
          ),
        ));
  }
}
