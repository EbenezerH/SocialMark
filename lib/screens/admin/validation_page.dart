import 'package:flutter/material.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/widgets/cours_widget.dart';

import '../../firebase/firebase_methodes.dart';
import '../../firebase/models.dart';
import '../../theme/theme.dart';
import '../../widgets/campaign_widget.dart';
import '../campaigns/campaign_detail_page.dart';

class ValidationPage extends StatefulWidget {
  final User user;
  const ValidationPage(this.user, {super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  bool visible1 = true;
  bool visible2 = false;
  bool visible3 = false;
  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() { 
              visible1 = !visible1;
              visible2 = false;
              visible3 = false;
              });
          },
          child: Container(
            height: 35,
            decoration: decorationButton(visible1? secondColor : buttonBackground),
            margin: EdgeInsets.only(bottom: visible1? 0 : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("   Campagnes en attente d'approbation", 
                  style: TextStyle(color: thirdColor, fontWeight: FontWeight.bold),)
                ),
                Icon(
                    visible1? Icons.arrow_drop_down_outlined:
                    Icons.arrow_right_outlined
                )
              ],
            ),
          ),
        ),

        Visibility(
          visible: visible1,
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: StreamBuilder<List<Campaign>>(
              stream: DatabaseService().retrieveAwaitValidationCC(collectionCampaigns),
              builder: (context, snapshot) {
                List<Campaign> toValidateCampaignList =[];
                  
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
                  if(element.isValidate == null){
                    toValidateCampaignList.add(element);
                  }
                }
                return ListView.builder(
                  itemCount: toValidateCampaignList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: CampagneWidget(
                      toValidateCampaignList[index],
                      currentUser: widget.user,
                      isEditMode: true,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder:(context) => CampaignDetailPage(
                          toValidateCampaignList[index],currentUser: widget.user, 
                          validationMode: true, isCampaign: true,)
                        ));
                      },
                    ),
                  );
                }
              )
            ),
          ),
        ),


        GestureDetector(
          onTap: () {
            setState(() { 
              visible1 = false;
              visible2 = !visible2;
              visible3 = false;
              });
          },
          child: Container(
            height: 35,
            decoration: decorationButton(visible2? secondColor : buttonBackground),
            margin: EdgeInsets.only(bottom: visible2? 0 : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("   Cours en attente d'approbation", 
                  style: TextStyle(color: thirdColor, fontWeight: FontWeight.bold),)
                ),
                Icon(
                    visible2? Icons.arrow_drop_down_outlined:
                    Icons.arrow_right_outlined
                )
              ],
            ),
          ),
        ),

        Visibility(
          visible: visible2,
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: StreamBuilder<List<Campaign>>(
              stream: DatabaseService().retrieveAwaitValidationCC(collectionCours),
              builder: (context, snapshot) {
                List<Campaign> toValidateCoursList =[];
                  
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
                  if(element.isValidate == null){
                    toValidateCoursList.add(element);
                  }
                }
                return ListView.builder(
                  itemCount: toValidateCoursList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: CoursWidget(
                      toValidateCoursList[index],
                      currentUser: widget.user,
                      isEditMode: true, 
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder:(context) => CampaignDetailPage(
                          toValidateCoursList[index],currentUser: widget.user, 
                          validationMode: true, isCampaign: false,)
                        ));
                      },
                    ),
                  );
                }
              )
            ),
          ),
        ),
      ],
    );
  }
}