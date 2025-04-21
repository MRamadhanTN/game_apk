import 'package:flutter/material.dart';
import 'package:game_apk/pages/main_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  nextMain()async{
    await Future.delayed(
      Duration(seconds: 5),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) => MainNavigation(),
    ),(route) => false);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextMain();
  }

  Color hexaColor(String hex){
    hex = hex.replaceAll('#', ''); //hapus hex
    if(hex.length == 6){
      hex = 'FF$hex';
    }
    return Color(int.parse(hex,radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/game.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 30),
                Text(
                  'Google Play Games',
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: hexaColor('#16C47F')
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: CircularProgressIndicator(
                color: hexaColor('#16C47F'),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: hexaColor('#B6FFA1'),
    );
  }
}
