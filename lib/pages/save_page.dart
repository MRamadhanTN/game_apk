import 'package:flutter/material.dart';
import 'package:game_apk/fragments/detail_game.dart';
import 'package:game_apk/model/get_list_game.dart';
import 'package:game_apk/repository/games_repo.dart';
import 'package:google_fonts/google_fonts.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  List<GetListGame> saveGamesList = [];

  void getSaveGames() async {
    try {
      final value = await GameRepo.getListGame();
      if (mounted) {
        setState(() {
          saveGamesList = value.take(5).toList(); // Batasi hanya 5 item
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSaveGames();
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aplikasi saya",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: saveGamesList.length,
                itemBuilder: (context, index) {
                  final game = saveGamesList[index];
                  return Card(
                    color: hexaColor('#16C47F'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          game.thumbnail!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        game.title!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        game.genre!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameDetailPage(game: game)));
                        },
                        child: Text(
                          'Open',
                          style: TextStyle(
                            color: hexaColor('3F4F44'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}