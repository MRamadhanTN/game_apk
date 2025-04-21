class GetListGame {
  GetListGame({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
  });

  final int? id;
  final String? title;
  final String? thumbnail;
  final String? shortDescription;
  final String? gameUrl;
  final String? genre;
  final String? platform;
  final String? publisher;
  final String? developer;
  final DateTime? releaseDate;
  final String? freetogameProfileUrl;

  factory GetListGame.fromJson(Map<String, dynamic> json){
    return GetListGame(
      id: json["id"],
      title: json["title"],
      thumbnail: json["thumbnail"],
      shortDescription: json["short_description"],
      gameUrl: json["game_url"],
      genre: json["genre"],
      platform: json["platform"],
      publisher: json["publisher"],
      developer: json["developer"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      freetogameProfileUrl: json["freetogame_profile_url"],
    );
  }
}