
import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/firebase/models.dart' as u;

import '../../firebase/firebase_methodes.dart';
import '../../firebase/models.dart';
import '../../widgets/add_campaign_or_cours.dart.dart';
import '../../widgets/cours_widget.dart';
import '../campaigns/campaign_detail_page.dart';
import 'add_cours_page.dart';


class CoursPage extends StatefulWidget {
  final u.User user;
  const CoursPage(this.user, {super.key});

  @override
  State<CoursPage> createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5),
        child: StreamBuilder<List<Campaign>>(
            stream: DatabaseService().retrieveValidateCC(collectionCours),
            builder: (context, snapshot) {
              List<Campaign> validateCoursList =[];
    
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
              for (var element in snapshot.data!) {
                if(element.isValidate != null && element.isValidate!){
                  validateCoursList.add(element);
                }
              }
              return ListView.builder(
                itemCount: validateCoursList.length,
                itemBuilder: (context, index) => GestureDetector(
                  child: CoursWidget(validateCoursList[index], currentUser: widget.user,),
                  onTap: () {
                    if (validateCoursList[index].likedList!.contains("${widget.user.id}-liked")) {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => 
                      CampaignDetailPage(validateCoursList[index], currentUser: widget.user, isCampaign: false,)));
                    }else{
                      showNotificationInApp(context, "Incrivez-vous au cours d'abord");
                    }
                  },
                ),
              );
            }
          ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 25,
        child: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => AddCoursPage(addCampaignOrCours: AddCampaignOrCours(widget.user, isCampaign: false,)),));
        }, 
        icon: const Icon(Icons.add)
      ),
      )
    );
  }
}
