class CastModel {

  final String name ;
  final String character ;
  final String imageUrl ;

  CastModel({
    required this.name,
    required this.character,
    required this.imageUrl });

  factory CastModel.fromJson(Map<String,dynamic> json)
  {
    return CastModel(
        name: json["name"],
        character: json["character_name"],
        imageUrl: json["url_small_image"]);
  }
}