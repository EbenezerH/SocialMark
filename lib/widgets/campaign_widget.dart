import 'dart:io';
import 'package:flutter/material.dart';
import '../constant/constants.dart';
import '../firebase/firebase_methodes.dart';
import '../firebase/models.dart';
import '../theme/theme.dart';

class CampagneWidget extends StatefulWidget {
  final Campaign campaign;
  final User currentUser;
  final bool isEditMode;
  final bool isCampaign;
  const CampagneWidget(this.campaign,{super.key, required this.currentUser, this.isEditMode=false, this.isCampaign=true});

  @override
  State<CampagneWidget> createState() => _CampagneWidgetState();
}
int likedState = 0;
class _CampagneWidgetState extends State<CampagneWidget> {
  late bool suscribe;
  bool adminAutorisation = false;
  String name = "";
  @override
  void initState() {
    if (widget.currentUser.role == UserRole.admin) {
      adminAutorisation = true;
    }
    if(widget.campaign.likedList!.contains("${widget.currentUser.id}-liked")){
      suscribe = true;
    } else{
      suscribe = false;
    }
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
    return Stack(
      children: [
        Container(
          width: width-20,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(width: 0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Container(
                    width: 42,
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
                      Container(
                        width: width-110,
                        alignment: Alignment.center,
                        child: Text(widget.campaign.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: width*0.7,
                        child: Text(widget.campaign.description,
                              overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.campaign.category!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),

                          Text(widget.campaign.time.toString().split(" ")[0]),
                          Text(widget.campaign.time.toString().split(" ")[1].split(".")[0]),

                          FutureBuilder(
                            future: DatabaseService().getUser(widget.campaign.authorId),
                            builder:(context, snapshot) {
                              if (snapshot.hasData) {
                                  name = "${snapshot.data!.firstName} ${snapshot.data!.lastName}";
                              }
                            return Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  );
                          },),

                          //Text("Points : ${widget.campaign.vote}"),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(widget.campaign.vote!.split("/")[0]),
                                  GestureDetector(
                                    onTap: 
                                    // widget.isEditMode ? null :
                                    //   likedState >= 0 ?
                                    //     () {
                                          
                                    //       DatabaseService().addStringToListCampaign(widget.campaign, 
                                    //       "${widget.currentUser.id}-unLiked", "${widget.currentUser.id}-liked",
                                    //       collectionCampaigns
                                    //       );
                                    //       setState(() {
                                    //         likedState = -1;
                                    //       });
                                    //     }
                                    //   : 
                                      null,
                                    child: Icon(
                                      Icons.remove,
                                      size: 20, color: 
                                      widget.campaign.likedList != [] ?
                                        widget.campaign.likedList!.contains("${widget.currentUser.id}-unLiked") ? firstColor
                                        : grey
                                      : grey,
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              
                              Column(
                                children: [
                                  Text(widget.campaign.vote!.split("/")[1]),
                                  GestureDetector(
                                    onTap:  
                                    // widget.isEditMode ? null :
                                    //   likedState <= 0 ? 
                                    //     () {
                                    //       DatabaseService().addStringToListCampaign(widget.campaign, "${widget.currentUser.id}-liked", 
                                    //       "${widget.currentUser.id}-unLiked", collectionCampaigns);
                                            
                                    //       setState(() {
                                    //         likedState = 1;
                                    //       });
                                    //     }
                                    //   : 
                                      null,
                                    child: Icon(
                                      Icons.add,
                                      size: 20, color: 
                                      widget.campaign.likedList != [] ?
                                        widget.campaign.likedList!.contains("${widget.currentUser.id}-liked") ? firstColor
                                        : grey
                                      : grey,
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ) 
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    height: 110,
                    width: width/2,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: 
                          FutureBuilder(
                            future: loadLocalImagePath(widget.campaign.id!, widget.campaign.imageUrl!),
                            builder:(context, snapshot) {
                              Widget snapshotWidget = const Center(child: CircularProgressIndicator());
                              if (snapshot.hasData && snapshot.data != '') {
                                snapshotWidget = Image.file(File(snapshot.data!));
                              }
                            return snapshotWidget;
                          },),
                      
                  )
                ],
              ),
            ],
          )
        ),
        adminAutorisation || widget.isEditMode ?  Positioned(
            top: 5, right: -8,
            child: IconButton(onPressed: (){
              buildDeleteCampaignDialog(context, widget);
            },
            icon: Icon(Icons.delete, color: red,)),
          ): const SizedBox()
      ],
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