import 'package:movies_app/core/models/cast_model.dart';


class MovieDetailsModel {
  final int id;
  final String url;
  final String title;
  final String year;
  final double rating;
  final int runTime;
  final List<String> genres;
  final int likeCount;
  final String descriptionFull;
  final String backgroundImage;
  final String largeCoverImage;
  final List<CastModel> cast;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;


  MovieDetailsModel({
    required this.id,
    required this.url,
    required this.title,
    required this.year,
    required this.rating,
    required this.runTime,
    required this.genres,
    required this.likeCount,
    required this.descriptionFull,
    required this.backgroundImage,
    required this.largeCoverImage,
    required this.cast,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3
  });

  /// Named Constructor
  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json["id"] ?? 0,
      url: json["url"] ?? '',
      title: json["title"] ?? '',
      year: json["year"]?.toString() ?? '',
      // استخدام as num للتعامل السليم مع int أو double تحسباً للأخطاء
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      runTime: (json["runtime"] as num?)?.toInt() ?? 0,
      // تحويل مصفوفة JSON النصية إلى List<String> بأمان
      genres: json["genres"] != null
          ? List<String>.from(json["genres"].map((e) => e.toString()))
          : [],
      likeCount: (json["like_count"] as num?)?.toInt() ?? 0,
      descriptionFull: json["description_full"] ?? '',
      backgroundImage: json["background_image_original"] ?? json["background_image"] ?? '',
      largeCoverImage: json["large_cover_image"] ?? json["medium_cover_image"] ?? '',
      cast: json["cast"] != null
        ? List<CastModel>.from(json["cast"].map((e) => CastModel.fromJson(e)))
        : [],
      mediumScreenshotImage1: json["medium_screenshot_image1"],
      mediumScreenshotImage2: json["medium_screenshot_image2"],
      mediumScreenshotImage3: json["medium_screenshot_image3"]
    );
  }


}