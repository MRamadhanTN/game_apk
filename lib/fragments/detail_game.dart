import 'package:flutter/material.dart';
import 'package:game_apk/fragments/settings.dart';
import 'package:game_apk/model/get_list_game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailPage extends StatelessWidget {
  final GetListGame game;

  const GameDetailPage({super.key, required this.game});

  void _openGameUrl() async {
    final Uri url = Uri.parse(game.gameUrl!);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
      appBar: AppBar(
        backgroundColor: hexaColor('#16C47F'),
        title: Text(
          game.title!, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_rounded,color: Colors.white),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                game.thumbnail!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              game.title!,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Release Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(game.releaseDate!.toString()))}",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text(
              game.shortDescription!,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text("Publisher: ${game.publisher!}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
            Text("Developer: ${game.developer!}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(game.genre!)),
                Chip(label: Text(game.platform!)),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexaColor('#16C47F'),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _openGameUrl,
                child: Text(
                  "Play Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}