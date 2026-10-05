import '../../models/genres_model.dart';

abstract class GenresData {

  GenresData._();

  static final List<GenresModel> genresList = [
    GenresModel(name: "Action"),
    GenresModel(name: "Adventure"),
    GenresModel(name: "Animation"),
    GenresModel(name: "Biography"),
    GenresModel(name: "Comedy"),
    GenresModel(name: "Crime"),
    GenresModel(name: "Documentary"),
    GenresModel(name: "Drama"),
    GenresModel(name: "Family"),
    GenresModel(name: "Fantasy"),
    GenresModel(name: "Film-Noir"),
    GenresModel(name: "Game-Show"),
    GenresModel(name: "History"),
    GenresModel(name: "Horror"),
    GenresModel(name: "Music"),
    GenresModel(name: "Musical"),
    GenresModel(name: "Mystery"),
    GenresModel(name: "News"),
    GenresModel(name: "Reality-TV"),
    GenresModel(name: "Romance"),
    GenresModel(name: "Sci-Fi"),
    GenresModel(name: "Short"),
    GenresModel(name: "Sport"),
    GenresModel(name: "Talk-Show"),
    GenresModel(name: "Thriller"),
    GenresModel(name: "War"),
    GenresModel(name: "Western"),
  ];
}