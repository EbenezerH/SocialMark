import 'package:flutter/material.dart';
import 'package:mark_soc/screens/campaigns/campaign_page.dart';
import 'package:mark_soc/screens/cours/cours_page.dart';
import 'package:mark_soc/screens/publication_page.dart';
import 'package:mark_soc/screens/admin/validation_page.dart';

import '../firebase/firebase_methodes.dart';
import '../firebase/models.dart';
import '../theme/theme.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_drawer.dart';
import 'authentification/login.dart';


class NavBarPages extends StatefulWidget {
  final User user;
  const NavBarPages(this.user, {super.key});

  @override
  NavBarPagesState createState() => NavBarPagesState();
}

class NavBarPagesState extends State<NavBarPages> {
  @override
  void initState() {
      getAllUsers();
      widget.user.role == UserRole.admin ? items.add(
          const BottomNavigationBarItem(
            label: 'A valider',
            icon: Icon(Icons.schedule),
          ),
      ): null;
    super.initState();
  }
  List<User>? usersList;
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    var pages = [
      CoursPage(widget.user),
      CampaignPage(widget.user),
      PublicationPage(widget.user),
    ];
    widget.user.role == UserRole.admin ? pages.add(ValidationPage(widget.user)):null;

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: MyDrawer(widget.user),
      body: WillPopScope(onWillPop: () => onWillPop(context, buildExitDialog(context)), child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: pages[_currentIndex],
      )),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Color(0xFF6200EE),
        backgroundColor: Colors.white,
        selectedItemColor: firstColor,
        //unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: items
      ),
    );
  }
  Future getAllUsers()async{
    usersList = await DatabaseService().retrieveUser();
  }
  List<BottomNavigationBarItem> items = [
          const BottomNavigationBarItem(
            label: 'Cours',
            icon: Icon(Icons.book_outlined),
          ),
          const BottomNavigationBarItem(
            label: 'Campagnes',
            icon: Icon(Icons.campaign),
          ),
          const BottomNavigationBarItem(
            label: 'Publications',
            icon: Icon(Icons.published_with_changes),
          ),
        ];
}
