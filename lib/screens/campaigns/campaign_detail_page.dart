import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import '../../firebase/firebase_methodes.dart';
import '../../firebase/models.dart';
import '../../theme/theme.dart';
import '../../widgets/my_app_bar.dart';

class CampaignDetailPage extends StatefulWidget {
  final Campaign campaign;
  final User currentUser;
  final bool validationMode;
  final bool isCampaign;
  const CampaignDetailPage(this.campaign,{super.key, required this.currentUser, 
  this.validationMode= false, required this.isCampaign});

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  int likedState = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


   Future<String> _loadLocalProfil() async {
    User user = await DatabaseService().getUser(widget.campaign.authorId);
    String imagePath = await loadLocalImagePath(widget.campaign.id! + user.id, user.imageProfilePath!);
    return imagePath;
   }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<Campaign>(
        stream: widget.isCampaign ? DatabaseService().getCampaignStream(widget.campaign.id!, collectionCampaigns):
        DatabaseService().getCampaignStream(widget.campaign.id!, collectionCours),
        builder: (context, snapshot) {
          Campaign? campaign;
            if (snapshot.connectionState != ConnectionState.active &&
                snapshot.connectionState != ConnectionState.done) {
              return detailsWidget(width, context, widget.campaign);
            }
            campaign = snapshot.data!;
          return detailsWidget(width, context, campaign);
      }
    );
  }

  Scaffold detailsWidget(double width, BuildContext context, Campaign campaign) {
    return Scaffold(
    appBar: const MyAppBar(),
    body: Container(
          width: width,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 180,
                    width: width-14,
                    child:FutureBuilder(
                      future: loadLocalImagePath(campaign.id!, campaign.imageUrl!),
                      builder:(context, snapshot) {
                        Widget snapshotWidget = const Center(child: CircularProgressIndicator());
                        if (snapshot.hasData && snapshot.data != '') {
                          snapshotWidget = Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                          );
                        }
                      return snapshotWidget;
                    },),
                
                  ),
    
                  const SizedBox(height: 10),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        margin: const EdgeInsets.only(right: 5),
                        child: FutureBuilder(
                          future: _loadLocalProfil(),
                          builder:(context, snapshot) {
                            Widget snapshotWidget = const CircleAvatar();
                            if (snapshot.hasData && snapshot.data! != "") {
                              Widget snapshotWidget = const CircleAvatar(child: Center(child: CircularProgressIndicator()));
                                if (snapshot.hasData && snapshot.data != '') {
                                  snapshotWidget = CircleAvatar(backgroundImage: Image.file(File(snapshot.data!)).image);
                                }
                              return snapshotWidget;
                            }
                          return snapshotWidget;
                        },),
                      ),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width-110, 
                            child: Text(campaign.title,
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: width-22, height: 20,
                child: Text(
                  campaign.category!.name,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
                ),
              ),
    
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Text(
                      campaign.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 20,
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FutureBuilder(
                          future: DatabaseService().getUser(campaign.authorId),
                          builder:(context, snapshot) {
                            Widget snapshotWidget = Container(
                              width: 15, height: 15,
                              margin: const EdgeInsets.only(left: 15),
                              child: const Center(child: CircularProgressIndicator()));
                            if (snapshot.hasData) {
                              snapshotWidget = Text("by ${snapshot.data!.firstName} ${snapshot.data!.lastName}");
                            }
                          return snapshotWidget;
                        },),
                      ],
                    ),
                  ),
    
                  SizedBox(
                    height: 20,
                    child: Text(
                      textAlign: TextAlign.start,
                      campaign.time.toString().split(".")[0]),
                  ),
                  
                  //Commentaires
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(height: 2, color: Colors.black)),
                      const SizedBox(width: 5,),
                      const Text(
                        textAlign: TextAlign.start,
                        "Commentaires", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(height: 2, color: Colors.black))
                    ],
                  ),
                  const SizedBox(height: 5),

                  Column(
                    children: [                      
                      TextField(
                        controller: commentController,
                        minLines: 2,
                        maxLines: 20,
                        decoration: InputDecoration(
                          filled: false,
                          enabled: true,
                          //labelText: "Description",
                          hintText: "Cliquez pour commenter",
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
                        onChanged: (value) {
                          setState(() { });
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.newline,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(onPressed:() {
                            if (commentController.text.isNotEmpty) {
                              DatabaseService().addComment(
                                Comment(text: commentController.text, authorId: widget.currentUser.id), widget.campaign.id!);
                            }
                          }, child: const Text("Commenter")),
                        ],
                      ),
                    ],
                  ),
                  
                  StreamBuilder<List<Comment>>(
                    stream: DatabaseService().retrieveComments(widget.campaign.id!),
                    builder: (context, snapshot) {
                      List<Comment> commentsList;
                        if (snapshot.connectionState != ConnectionState.active &&
                            snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text('Awaiting...'),
                                ),
                              ],
                            ),
                          );
                        }
                        snapshot.data != null ? commentsList = snapshot.data! : commentsList = [];
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: commentsList.length,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                    future: DatabaseService().getUser(commentsList[index].authorId),
                                    builder:(context, snapshot) {
                                      Widget snapshotWidget = Container(
                                        width: 15, height: 15,
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Center(child: CircularProgressIndicator()));
                                      if (snapshot.hasData) {
                                        snapshotWidget = Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                        style: const TextStyle(fontWeight: FontWeight.w500)
                                        );
                                      }
                                    return snapshotWidget;
                                  },),
                                  Text(commentsList[index].time.toString().split(".")[0])
                                ],
                              ),
                              Text(commentsList[index].text),
                              const SizedBox(height: 15,),
                            ],
                          )
                        ),
                      );
                  }
                  ),
                  
                  const SizedBox(height: 15,),


                  const SizedBox(height: 100),
                  ]),
                ),
              )
            ],
          )),
    floatingActionButton: 
      widget.validationMode ? ValidationFloatButtom(widget: widget, context: context, isCampaign: widget.isCampaign) : 
      widget.isCampaign?
      Container(
    decoration: BoxDecoration(
      border: Border.all(width: 0.7),
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromARGB(177, 33, 32, 28),
    ),
    width: 100, height: 60,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    campaign.vote!.split("/")[0],
                    style: TextStyle(color: white),
                  ),
                  GestureDetector(
                    onTap:
                      likedState >= 0 ?
                        () async {
                          DatabaseService().addStringToListCampaign(campaign, "${widget.currentUser.id}-unLiked", 
                          "${widget.currentUser.id}-liked", widget.isCampaign ? collectionCampaigns : collectionCours);
                          setState(() {
                            likedState = -1;
                          });
                          User campaignAuthor = await DatabaseService().getUser(widget.campaign.authorId);
                          campaignAuthor.updateUsergradeValue(campaignAuthor.id, -5);
                        }
                      : null,
                    child: Icon(
                      Icons.thumb_down,
                      size: 30, color: 
                      campaign.likedList != [] ?
                        campaign.likedList!.contains("${widget.currentUser.id}-unLiked") ? firstColor
                        : grey
                      : grey,
                    )
                  ),
                ],
              ),
              const SizedBox(width: 10),
              
              Column(
                children: [
                  Text(campaign.vote!.split("/")[1],
                    style: TextStyle(color: white),),
                  GestureDetector(
                    onTap:
                      likedState <= 0 ? 
                        () async {
                          DatabaseService().addStringToListCampaign(campaign, "${widget.currentUser.id}-liked", 
                          "${widget.currentUser.id}-unLiked", widget.isCampaign ? collectionCampaigns : collectionCours);
                          setState(() {
                            likedState = 1;
                          });
                          User campaignAuthor = await DatabaseService().getUser(widget.campaign.authorId);
                          campaignAuthor.updateUsergradeValue(campaignAuthor.id, 5);
                        }
                      : null,
                    child: Icon(
                      Icons.thumb_up,
                      size: 30, color: 
                      campaign.likedList != [] ?
                        campaign.likedList!.contains("${widget.currentUser.id}-liked") ? firstColor
                        : grey
                      : grey,
                    )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
  ):null,
  );
  }
}

class ValidationFloatButtom extends StatelessWidget {
  const ValidationFloatButtom({
    super.key,
    required this.widget,
    required this.context,
    required this.isCampaign,
  });

  final CampaignDetailPage widget;
  final BuildContext context;
  final bool isCampaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.7),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(177, 33, 32, 28),
      ),
      width: 120, height: 60,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    DatabaseService().updateCampainField(widget.campaign.id!, "isValidate", false, 
                      widget.isCampaign? collectionCampaigns : collectionCours
                    );
                    widget.campaign.isValidate = false;
                    Navigator.pop(context);
                    User campaignAuthor = await DatabaseService().getUser(widget.campaign.authorId);
                    campaignAuthor.updateUsergradeValue(campaignAuthor.id, widget.isCampaign ? -25 : -50);
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 30, color: red,
                  )
                ),
                const SizedBox(width: 10),
                
                GestureDetector(
                  onTap: () async {
                    DatabaseService().updateCampainField(widget.campaign.id!, "isValidate", true, 
                      widget.isCampaign? collectionCampaigns : collectionCours
                    );
                    widget.campaign.isValidate = true;
                    Navigator.pop(context);
                    User campaignAuthor = await DatabaseService().getUser(widget.campaign.authorId);
                    campaignAuthor.updateUsergradeValue(campaignAuthor.id, widget.isCampaign ? 25 : 50);
                  },
                  child: Icon(
                    Icons.check_circle_outline_outlined,
                    size: 30, color: green,
                  )
                ),
              ],
            ),
          ],
        ),
    );
  }
}

Future<void> buildDeleteCampaignDialog(BuildContext context, Widget widget) async {
  await showDialog(
    context: context,
    builder: (context) => deleteCampaignAlert(context, widget),
  );
}

AlertDialog deleteCampaignAlert(BuildContext context, widget) {
  return AlertDialog(
    backgroundColor: white,
    title: Text('Attention !', style: TextStyle(color: black)),
    content: Text("Voulez-vous vraiment supprimer cette campagne ?",
        style: TextStyle(color: black87)),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text('Non', style: TextStyle(fontSize: 17, color: black)),
      ),
      TextButton(
        onPressed: () {
          DatabaseService().deleteCampaign(widget.campaign,  widget.isCampaign? collectionCampaigns : collectionCours);
          Navigator.of(context).pop();
        },
        child: Text('Oui', style: TextStyle(fontSize: 17, color: red)),
      ),
    ],
  );
}
