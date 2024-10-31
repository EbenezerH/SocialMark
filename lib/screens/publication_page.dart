// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/firebase/firebase_methodes.dart';
import '../firebase/models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mark_soc/firebase/models.dart' as u;

import '../theme/theme.dart';
import '../widgets/campaign_widget.dart';
import '../widgets/cours_widget.dart';

class PublicationPage extends StatefulWidget {
  u.User user;
  PublicationPage(this.user, {super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  @override
  void initState() {
    setState(() {
      //getCampaignImagePathSF();
    });
    super.initState();
  }
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int titleMinLength = 15;
  int descriptionMinLength = 30;
  final picker = ImagePicker();
  bool isUploading = false;
  u.Category categoryValue = u.Category.getDefault();
  File? campaignImg;
  List<u.Category> allCategories = u.CategoryExtension.allValues;
  // bool campaignAwaiting = false;
  // bool campaignValidated = false;
  // bool campaignRejected = false;
  // bool coursAwaiting = false;
  // bool coursValidated = false;
  // bool coursRejected = false;

  List<bool> visibilitisValues = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5,),
              // Visibility(
              //   visible: visibilitisValues[0] || visibilitisValues[3],
              //   child: Text("En attente")),
              blocWidget("   Campagnes en attente de validation", 0, DatabaseService().retrieveAwaitValidationCC(collectionCampaigns), true, height),
              blocWidget("   Cours en attente de validation", 3, DatabaseService().retrieveAwaitValidationCC(collectionCours), false, height),
              
              // Visibility(
              //   visible: visibilitisValues[1] || visibilitisValues[4],
              // child: Text("Validés")),

              blocWidget("   Campagnes Validées", 1, DatabaseService().retrieveValidateCC(collectionCampaigns), true, height),
              blocWidget("   Cours Validés", 4, DatabaseService().retrieveValidateCC(collectionCours), false, height),
              
              // Visibility(
              //   visible: visibilitisValues[2] || visibilitisValues[5],
              // child: Text("Rejetés")),
              blocWidget("   Campagnes Rejetées", 2, DatabaseService().retrieveNotValidateCC(collectionCampaigns), true, height),
              blocWidget("   Cours Rjetés", 5, DatabaseService().retrieveNotValidateCC(collectionCours), false, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget blocWidget(String title, int index, streamFonction, bool isCampaign, double height) {
    return StreamBuilder<List<Campaign>>(
      stream: streamFonction,
      builder: (context, snapshot) {
        List<Campaign> newList =[];
  
        if (snapshot.connectionState != ConnectionState.active &&
            snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   width: 300,
                //   height: 20,
                //   child: CircularProgressIndicator(),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 16),
                //   child: Text('Awaiting...'),
                // ),
              ],
            ),
          );
        }
        for (var element in snapshot.data!) {
          if(element.authorId == widget.user.id){
            newList.add(element);
          }
        }

        return Column(
          children: [
            GestureDetector(
            onTap: () {
              updateVisibilitiesValues(index);
            },
            child: visibilitisValues[index] || allVisibilityIsFalse() ? Container(
              height: 35,
              decoration: decorationButton(visibilitisValues[index]? secondColor : buttonBackground),
              margin: EdgeInsets.only(bottom: visibilitisValues[index]? 0 : 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(title, 
                    style: const TextStyle(color: thirdColor, fontWeight: FontWeight.bold),)
                  ),
                  Row(
                    children: [
                      Text(newList.length.toString(), 
                        style: const TextStyle(color: thirdColor, fontWeight: FontWeight.bold),),
                      Icon(
                        visibilitisValues[index]? Icons.arrow_drop_down_outlined:
                        Icons.arrow_right_outlined
                      )
                    ],
                  ),
                ],
                ),
              ): const SizedBox(),
            ),
            Visibility(
            visible: visibilitisValues[index],
            child: Container(
              height: height-200,
              margin: const EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: isCampaign ? CampagneWidget(
                      newList[index],
                      currentUser: widget.user,
                      isEditMode: true,
                    ):
                    CoursWidget(
                      newList[index],
                      currentUser: widget.user,
                      isEditMode: true,
                    ),
                    onTap: () async {
                    
                    },
                  ),
                )
              )
            ),
          ],
        );
      }
    );
  }

  bool allVisibilityIsFalse(){
    bool state;
    if (visibilitisValues.every((element) => element == false)) {
      state = true;
    }else{
      state = false;
    }
    return state;
  }

  void updateVisibilitiesValues(int index){
    for (int i = 0; i < visibilitisValues.length; i++) {
    if (i == index) {
      // Met à jour l'élément à l'index donné à sa valeur contraire
      setState(() {
        visibilitisValues[i] = !visibilitisValues[i];
      });
    } else {
      // Met à false tous les autres éléments
      setState(() {
        visibilitisValues[i] = false;
      });
    }
  }
  }
}
