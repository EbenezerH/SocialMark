import 'package:flutter/material.dart';
import 'package:mark_soc/widgets/my_app_bar.dart';

class Parameters extends StatefulWidget {
  const Parameters({super.key});

  @override
  State<Parameters> createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Paramètres"),
      body: Center(
        child: Text("En Cours de développement"),
      ),
    );
  }
}