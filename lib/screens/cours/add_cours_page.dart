import 'package:flutter/material.dart';
import 'package:mark_soc/widgets/add_campaign_or_cours.dart.dart';
import 'package:mark_soc/widgets/my_app_bar.dart';


class AddCoursPage extends StatefulWidget {
  final AddCampaignOrCours addCampaignOrCours;
  const AddCoursPage({super.key, required this.addCampaignOrCours});

  @override
  State<AddCoursPage> createState() => _AddCoursPageState();
}

class _AddCoursPageState extends State<AddCoursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.addCampaignOrCours,
            ],
          ),
        ),
      ),
    );
  }
}