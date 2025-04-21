import 'package:flutter/material.dart';
import 'package:game_apk/fragments/settings.dart';
import 'package:game_apk/pages/home_page.dart';
import 'package:game_apk/pages/save_page.dart';
import 'package:game_apk/pages/top_game_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  Color hexaColor(String hex){
    hex = hex.replaceAll('#', ''); //hapus hex
    if(hex.length == 6){
      hex = 'FF$hex';
    }
    return Color(int.parse(hex,radix: 16));
  }
  
  List<String> title = [
    'Game Store',
    'Top Games',
    'My Games',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: hexaColor('#16C47F'),
              title: AnimatedBuilder(
                animation: tabController,
                builder: (context, _) {
                  return Text(
                    title[tabController.index],
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  tooltip: 'Settings',
                ),
              ],
              centerTitle: true,
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  HomePage(),
                  TopGamesPage(),
                  SavePage(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: hexaColor('#16C47F'),
              height: 60,
              child: TabBar(
                indicatorColor: hexaColor('#B6FFA1'),
                labelColor: hexaColor('#B6FFA1'),
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home, size: 30),
                  ),
                  Tab(
                    icon: Icon(Icons.local_fire_department_rounded, size: 30),
                  ),
                  Tab(
                    icon: Icon(Icons.download, size: 30),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
