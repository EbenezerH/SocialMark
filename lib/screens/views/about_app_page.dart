import 'package:flutter/material.dart';
import 'package:mark_soc/widgets/my_app_bar.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "A Propos"),
      body: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Le projet SocialMark représente une avancée significative dans le domaine du marketing social en"
              "proposant une application mobile intégrée et spécialisée. Grâce à ses fonctionnalités de création, de"
              "gestion, de validation et de formation, SocialMark répond de manière innovante aux besoins spécifiques"
              "des campagnes de marketing social.\n\n"
              "En conclusion, SocialMark a le potentiel de transformer la manière dont les campagnes de marketing"
              "social sont gérées et évaluées, en offrant une plateforme unique et efficace qui stimule l'engagement"
              "communautaire et l'impact social. L'amélioration continue de"
              "SocialMark ouvrira la voie à de nouvelles opportunités et innovations dans le domaine du marketing"
              "social.\n"
              "Ensemble pour impacter le marketing social",
              textAlign: TextAlign.justify,
            ),
            Text("\n\nDernière version : 1.2", style: TextStyle(fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}