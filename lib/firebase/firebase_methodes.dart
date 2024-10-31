// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mark_soc/firebase/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/constants.dart';
import 'package:http/http.dart' as http;


Future<String> loadLocalImagePath(String key, String url) async {
  String imagePath = '';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String localImagePath = prefs.getString(key)??'';
  if (localImagePath != '') {
    imagePath = localImagePath;
  } else {
    imagePath = await downloadImage(key, url);
  }
  return imagePath;
}

Future<String> downloadImage(String key, String url) async {
  String imgPath = '';
  if (url != ''){

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;

      final Directory systemTempDir = await getTemporaryDirectory();
      final File localImage = File('${systemTempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await localImage.writeAsBytes(bytes);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, localImage.path);

      imgPath = localImage.path;
    } else {
      //throw Exception('Failed to load image: ${response.statusCode}');
    }
  }
  return imgPath;
}

  Future<String?> uploadImageToFB(BuildContext context, File? image, String campaignOrCoursField, User user) async {
    String? url;
    final storageReference = FirebaseStorage.instance.ref()
      .child("images/campaigns/${user.id}/${Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch}.jpg");
    if (image != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Téléchargement en cours...'),
              ],
            ),
          );
        },
      );

      final File imageFile = File(image.path);

      final uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {});

      url = await storageReference.getDownloadURL();
      
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      return url.toString();
    }
    return null;
  }


class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // addUser(User userData) async {
  //   await _db.collection("users").add(userData.toMap());
  // }

  setUser(User userData) async {
    await _db.collection(collectionUsers).doc(userData.id).set(userData.toMap());
  }

  updateUser(User userData) async {
    await _db.collection(collectionUsers).doc(userData.id).update(userData.toMap());
  }

  Future<void> deleteUser(String documentId) async {
    await _db.collection(collectionUsers).doc(documentId).delete();
  }

  Future<List<User>> retrieveUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(collectionUsers).get();
    return snapshot.docs
        .map((docSnapshot) => User.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<User> getUser(String id) async {
    User? user;
    try {
      var doc = (await _db.collection(collectionUsers).doc(id).get());
      user = User.fromDocumentSnapshot(doc);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return user!;
  }

  // Future<Campaign> getCampaign(String campaignId) async {
  //   var doc = (await _db.collection(collectionCampaigns).doc(campaignId).get());
  //   return Campaign.fromMap(doc);
  // }

  addCampaign(Campaign campaign) async { 
    DocumentReference<Map<String, dynamic>> out = await _db
      .collection(collectionCampaigns)
      .add(campaign.toMap());
      campaign.id = out.id;
    await _db
      .collection(collectionCampaigns)
      .doc(out.id).update({"id": out.id});
    // addStringToSF(out.id, theCampaignImage);
  }

  addCours(Campaign cours) async { 
    DocumentReference<Map<String, dynamic>> out = await _db
      .collection(collectionCours)
      .add(cours.toMap());
      cours.id = out.id;
    await _db
      .collection(collectionCours)
      .doc(out.id).update({"id": out.id});
    // addStringToSF(out.id, theCampaignImage);
  }

  deleteCampaign(Campaign campaign, String collection) async {
    await _db.collection(collection).doc(campaign.id).delete();
    deleteImage(campaign.imageUrl!);
  }

  Future<void> deleteImage(String imageUrl) async {
    // Obtenez la référence de l'image dans Firebase Storage à partir de l'URL
    try {
      final Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
    // Supprimer l'image à partir de la référence obtenue
    await storageRef.delete();
      
    } catch (e) {
      debugPrint(e.toString());
    }
    
  }

  // setCampaign(Campaign campaign, User user) async {
  //   await _db
  //         .collection("campaigns")
  //         .doc("${user.id}-CampN0${campaignCounter + 1}").set(campaign.toMap());
  //   campaignCounter+=1;
    
  // }
  Stream<Campaign> getCampaignStream(String campaignId, String collection) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
        _db.collection(collection).doc(campaignId).snapshots();

    return snapshot.map((e) =>  Campaign.fromMap(e));
  }
  
  Stream<List<Campaign>> retrieveValidateCC(String collection) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _db.collection(collection).orderBy('time', descending: true).snapshots();

    return snapshot
        .map((event) => event.docs.map((e) => Campaign.fromMap(e)).where((campaign) => campaign.isValidate != null && campaign.isValidate!).toList());
  }
  Stream<List<Campaign>> retrieveNotValidateCC(String collection) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _db.collection(collection).orderBy('time', descending: true).snapshots();

    return snapshot
        .map((event) => event.docs.map((e) => Campaign.fromMap(e)).where((campaign) => campaign.isValidate != null && !campaign.isValidate!).toList());
  }

  Stream<List<Campaign>> retrieveAwaitValidationCC(String collection) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _db.collection(collection).orderBy('time', descending: true).snapshots();
    
    return snapshot.map((event) =>
      event.docs.map((e) => Campaign.fromMap(e)).where((campaign) => campaign.isValidate == null).toList());
  }


  // Méthode pour écouter les modifications de l'image dans Firebase Storage
  void listenToImageChanges() {
    // Référence à l'image dans Firebase Storage
    Reference imageRef = FirebaseStorage.instance.ref().child('path/to/image.jpg');

    // Écouteur pour détecter les modifications de l'image
    imageRef.getMetadata().then((metadata) {
      // Si l'image est modifiée, mettez à jour le chemin de l'image dans SharedPreferences
      // String imageUrl = metadata.fullPath; // Obtenez le chemin de l'image dans Firebase Storage
      //addStringToSF(imageUrl); // Mettez à jour le chemin de l'image dans SharedPreferences
    });
  }
  Future<void> updateCampainField(String campaignId, String field, newValue, String collection) async {
      // Récupérer le document spécifié dans Firestore
      DocumentReference<Map<String, dynamic>?> documentReference = FirebaseFirestore.instance.collection(collection).doc(campaignId);
      // Mettre à jour le document avec la nouvelle liste
      await documentReference.update({field: newValue});
  }


  Future<void> addStringToListCampaign(Campaign campaign, String newValue, String removeValue, String collection) async {
    try {
      // Récupérer le document spécifié dans Firestore
      DocumentReference<Map<String, dynamic>?> documentReference = FirebaseFirestore.instance.collection(collection).doc(campaign.id);
      DocumentSnapshot<Map<String, dynamic>?> snapshot = await documentReference.get();

      // Vérifier si le document existe
      if (snapshot.exists) {
        // Récupérer la liste existante
        List<String> existingList = List<String>.from(snapshot.data()?["likedList"] ?? []);

        // Ajouter la nouvelle valeur à la liste
        if(existingList.contains(removeValue)){
          existingList.removeWhere((element) => element == removeValue);
        }
        existingList.add(newValue);
        // Mettre à jour le document avec la nouvelle liste
        await documentReference.update({"likedList": existingList});

        List<String> likedList=[];
        if (existingList != []) {
          for (var element in existingList) {
            if (element.contains("-liked")) {
              likedList.add(element);
            }
          }
        }
        List<String> unLikedList=[];
        if (existingList != []) {
          for (var element in existingList) {
            if (element.contains("-unLiked")) {
              unLikedList.add(element);
            }
          }
        }

        await documentReference.update({"vote": "${unLikedList.length}/${likedList.length}"});
        
      } else {
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  Stream<List<Comment>>? retrieveComments(String campaignId) {
  Stream<List<Comment>>? snapshot;
    try {
      final snap =
          _db.collection(collectionCampaigns).doc(campaignId).collection("comments").orderBy('time', descending: true).snapshots();
        snapshot = snap.map((event) => event.docs.map((e) => Comment.fromMap(e)).toList());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    return snapshot;
  }
  
  addComment(Comment comment, String campaignId) async { 
    DocumentReference<Map<String, dynamic>> out = await _db
      .collection(collectionCampaigns).doc(campaignId).collection("comments")
      .add(comment.toMap());
      comment.id = out.id;
    await _db
      .collection(collectionCampaigns).doc(campaignId).collection("comments")
      .doc(out.id).update({"id": out.id});
    // addStringToSF(out.id, theCampaignImage);
  }
}


addStringToSF(String kle, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kle, value);
}

addIntToSF(String kle, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(kle, value);
}

addBoolToSF(String kle, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(kle, value);
}

getAllStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  theUid = prefs.getString('uid')??'';
  theEmail = prefs.getString('email');
}
/*
getCampaignImagePathSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  theCampaignImage = prefs.getString('CampaignImage')??'';
    if (theCampaignImage != "") {
        campaignImg = File(theCampaignImage);
    }
}*/