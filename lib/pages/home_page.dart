import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:game_apk/fragments/detail_game.dart';
import 'package:game_apk/model/get_list_game.dart';
import 'package:game_apk/repository/games_repo.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GetListGame> gameList = [];

  void getGame() async {
    try {
      final value = await GameRepo.getListGame();
      if (mounted) {
        setState(() {
          gameList = value.take(5).toList(); // Batasi hanya 10 item
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
    // TODO: implement initState
    super.initState();
    getGame();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Banner
            FlutterCarousel(
              options: FlutterCarouselOptions(
                height: 180,
                autoPlay: true,
                enableInfiniteScroll: true,
                slideIndicator: CircularSlideIndicator(),
              ),
              items: gameList.isNotEmpty
                  ? gameList.map((game) {
                return ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    game.thumbnail!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList()
                  : [
                // Placeholder jika data masih kosong
                Center(child: CircularProgressIndicator()),
              ],
            ),
            SizedBox(height: 20),

            // Daftar Game Populer
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Game Populer",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: gameList.length,
              itemBuilder: (context, index) {
                final game = gameList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  color: hexaColor('#16C47F'),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                        fontWeight: FontWeight.w700,
                        color: Colors.white,

                      ),
                    ),
                    subtitle: Text(
                      game.genre!,
                      style: GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white,
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameDetailPage(game: game)));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
