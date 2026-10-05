class MovieModel {
  static const String collectionName = "Movie Collection";

  final String id;
  final String title;
  final String rating;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  bool isFavorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    this.isFavorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"]?.toString() ?? '',
      title: json["title"],
      rating: json["rating"]?.toString() ?? '0.0',
      smallCoverImage: json["small_cover_image"] ?? '',
      mediumCoverImage: json["medium_cover_image"] ?? '',
      largeCoverImage: json["large_cover_image"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "rating": rating,
      "small_cover_image": smallCoverImage,
      "medium_cover_image": mediumCoverImage,
      "large_cover_image": largeCoverImage,
      "isFavorite": isFavorite,
    };
  }
}