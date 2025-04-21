import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:game_apk/model/get_list_game.dart';


String Base_Url = 'https://www.freetogame.com/api/';

class GameRepo{
  static Future<List<GetListGame>>getListGame()async{
    String url = Base_Url + 'games?platform=pc';
    final respon = await http.get(Uri.parse(url));
    if(respon.statusCode == 200){
      final data = jsonDecode(respon.body) as List;
      List<GetListGame> res = data.map((value) => GetListGame.fromJson(value)).toList();
      return res;
    }
    throw 'Game tidak tersedia';
  }
}