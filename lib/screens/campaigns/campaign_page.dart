import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/screens/cours/add_cours_page.dart';
import 'package:mark_soc/screens/campaigns/campaign_detail_page.dart';
import '../../firebase/firebase_methodes.dart';
import '../../firebase/models.dart';
import '../../widgets/add_campaign_or_cours.dart.dart';
import '../../widgets/campaign_widget.dart';

class CampaignPage extends StatefulWidget {
  final User user;
  const CampaignPage(this.user, {super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5),
        child: StreamBuilder<List<Campaign>>(
            stream: DatabaseService().retrieveValidateCC(collectionCampaigns),
            builder: (context, snapshot) {
              List<Campaign> validateCampaignList =[];
    
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
                if(element.isValidate != null && element.isValidate == true){
                  validateCampaignList.add(element);
                }
              }
              return ListView.builder(
                itemCount: validateCampaignList.length,
                itemBuilder: (context, index) => GestureDetector(
                  child: CampagneWidget(validateCampaignList[index], currentUser: widget.user),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => 
                    CampaignDetailPage(validateCampaignList[index], currentUser: widget.user, isCampaign: true,)));
                  },
                  onLongPress: () {
                    
                  },
                ),
              );
            }
          ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 25,
        child: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => AddCoursPage(addCampaignOrCours: AddCampaignOrCours(widget.user)),));
        }, 
        icon: const Icon(Icons.add)
      ),
      )
    );
  }
}
