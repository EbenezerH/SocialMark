
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mark_soc/firebase/models.dart' as u;

import '../constant/constants.dart';
import '../firebase/firebase_methodes.dart';
import '../theme/theme.dart';

class AddCampaignOrCours extends StatefulWidget {
  final u.User user;
  final bool isCampaign;
  const AddCampaignOrCours(this.user,{super.key, this.isCampaign = true});

  @override
  State<AddCampaignOrCours> createState() => _AddCampaignOrCoursState();
}

class _AddCampaignOrCoursState extends State<AddCampaignOrCours> {
  @override
  void initState() {
    if(widget.isCampaign){
      setState(() { fieldCampaignsOrCours = "cours"; });
    }
    super.initState();
  }
  String fieldCampaignsOrCours = "campaigns";
  final _formkey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int titleMinLength = 15;
  int descriptionMinLength = 30;
  final picker = ImagePicker();
  bool isUploading = false;
  u.Category categoryValue = u.Category.getDefault();
  File? campaignImg;
  List<u.Category> allCategories = u.CategoryExtension.allValues;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
        Expanded(child: Container(color: Colors.black, height: 2, width: 180)),
        const SizedBox(width: 5),
            Text(widget.isCampaign? "Création de campagne": "Ajouter un cours",
            style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold
            ),
            ),
        const SizedBox(width: 5),
        Expanded(child: Container(color: Colors.black, height: 2, width: 180)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Image", 
              style: TextStyle(color: black, fontWeight: FontWeight.bold),)
            ),
            IconButton(
              onPressed: () => getImage(ImageSource.gallery),
            icon: const Icon(Icons.edit))
          ],
        ),
        Container(
          height: height/5,
          //width: width*0.9,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Center(
            child: campaignImg == null
            ? const Text('Cliquez sur le crayon pour ajouter une image')
            : Image.file(campaignImg!, fit: BoxFit.cover,),
          ),
        ),
        const SizedBox(height: 20),
  
  
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Catégorie", 
          style: TextStyle(color: black, fontWeight: FontWeight.bold),)
        ),
        Container(
          width: width,
          alignment: Alignment.centerRight,
          child: DropdownButton(
            value: categoryValue,
            items: [
              DropdownMenuItem(value: u.Category.none, child: Text(u.Category.none.name)),
              DropdownMenuItem(value: u.Category.health, child: Text(u.Category.health.name)),
              DropdownMenuItem(value: u.Category.education, child: Text(u.Category.education.name)),
              DropdownMenuItem(value: u.Category.environment, child: Text(u.Category.environment.name)),
              DropdownMenuItem(value: u.Category.law, child: Text(u.Category.law.name)),
              DropdownMenuItem(value: u.Category.community, child: Text(u.Category.community.name)),
              DropdownMenuItem(value: u.Category.social, child: Text(u.Category.social.name)),
              DropdownMenuItem(value: u.Category.roadSafety, child: Text(u.Category.roadSafety.name)),
              DropdownMenuItem(value: u.Category.psychology, child: Text(u.Category.psychology.name)),
              DropdownMenuItem(value: u.Category.other, child: Text(u.Category.other.name)),
            ],
            onChanged:(value) {
              setState(() {
                categoryValue = value!;
              });
            }, ),
        ),
        const SizedBox(height: 20),
  
        Form(
          key: _formkey,
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Titre", 
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),)
                ),
                titleController.text.length < titleMinLength ?
                Text(
                  (titleMinLength - titleController.text.length).toString(),
                  style: TextStyle(fontSize: 12.0, color: red),
                ) :
                Text(
                  "0",
                  style: TextStyle(fontSize: 12.0, color: green),
                )
              ],
            ),
            TextFormField(
              controller: titleController,
              maxLines: 2,
              minLines: 1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: false,
                enabled: true,
                labelStyle: const TextStyle(
                  color: firstColor,
                ),
                contentPadding: const EdgeInsets.only(
                    left: 20.0, bottom: 0, top: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: firstColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: red),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: firstColor),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              cursorColor: firstColor,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Le titre ne peut pas être vide";
                }
                else if (value.length < titleMinLength) {
                  return ("Le titre doit faire au moins $titleMinLength caractères");
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Description", 
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),)
                ),
                descriptionController.text.length < descriptionMinLength ?
                Text(
                  (descriptionMinLength - descriptionController.text.length).toString(),
                  style: TextStyle(fontSize: 12.0, color: red),
                ) :
                Text(
                  "0",
                  style: TextStyle(fontSize: 12.0, color: green),
                )
              ],
            ),
            TextFormField(
              controller: descriptionController,
              minLines: 4,
              maxLines: 20,
              decoration: InputDecoration(
                filled: false,
                enabled: true,
                //labelText: "Description",
                labelStyle: const TextStyle(
                  color: firstColor,
                ),
                contentPadding: const EdgeInsets.only(
                    left: 20.0, bottom: 0, top: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: firstColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: red),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: firstColor),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              cursorColor: firstColor,
              style: const TextStyle(
                  fontSize: 16),
              validator: (value) {
                if (value!.isEmpty) {
                  return "La description ne peut pas être vide";
                }
                else if (value.length <= descriptionMinLength){
                  return ("La description doit dépasser $descriptionMinLength caractères");
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() { });
              },
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 20),
          ],
        )),
        const SizedBox(height: 5),

        ElevatedButton(
          onPressed: ()async{
            if (_formkey.currentState!.validate()) {
              if(campaignImg == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image invalide !'),
                      duration: Duration(seconds: 3), // Définir la durée du SnackBar
                    )
                  );
              }else if(categoryValue == u.Category.none){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Précisez une catégorie !'),
                      duration: Duration(seconds: 3), // Définir la durée du SnackBar
                    )
                  );
              }else{
                String? imageUrl = await uploadImageToFB(context, campaignImg, fieldCampaignsOrCours, widget.user);
                if (imageUrl != null && imageUrl.isNotEmpty && imageUrl!= "null") {
                  await uploadCampaign(imageUrl);
                  setState(() { isUploading = false; });
                  Navigator.pop(context);
                  showNotificationInApp(context, 'Enregistrement réussi !');
                }
              }
            }
          }, child: const Text("Enregistrer")
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Future<void> uploadCampaign(String imageUrl )async{
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
      }
    );

    u.Campaign campaign =u.Campaign(
      title: titleController.text, 
      description: descriptionController.text, 
      category: categoryValue,
      authorId: widget.user.id,
      imageUrl: imageUrl,
      );
    if(widget.isCampaign) {
      await DatabaseService().addCampaign(campaign);
    }else{
      await DatabaseService().addCours(campaign);
    }
    Navigator.pop(context);
  }
  

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        campaignImg = File(pickedFile.path);
      });
    } else {
      debugPrint('No image selected.');
    }
  }
}