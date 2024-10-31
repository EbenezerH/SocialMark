import 'dart:math';

import 'package:flutter/material.dart';

List slogans = [
  '"Changez des Vies, Créez des Connexions"',
  '"Partagez, Aimez, Agissez"',
  '"Inspirez, Impliquez, Impactez"',
  '"Du Partage de Contenus au Changement de Comportements"',
  '''"De l'Influence à l'Action"''',
  '"Connectez-vous, Engagez-vous, Réussissez"',
  '''"Du Partage de Contenus à l'Élaboration de Solutions"''',
  '"Du Suivi des Tendances à la Création de Tendances"',
];

Random random = Random();
var element = slogans[random.nextInt(slogans.length)];

String imgPath = "assets/images/";
String appName = "Marketing Social";

String keyProfilImage = 'imageProfilePath';

String collectionCampaigns = "campaigns";
String collectionCours = "cours";
String collectionUsers = "users";

int imgIndex = 0;

String theUid ="";
String? theEmail;
//String theCampaignImage ="";
//String imageUrl = "";

List<String> categories = [
  "Santé",
  "Education",
  "Environnement",
  "Droit & Justice",
  "Communauté",
  "Social",
  "Sécurité Routière",
  "Psychologie",
];

List<String> envImages = [
  "env1.jpg",
  "env2.jpg",
  "env3.png"
];

showNotificationInApp(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3), // Définir la durée du SnackBar
    )
  );
}