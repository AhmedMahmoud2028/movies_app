import 'package:movies_app/core/models/movie_details_model.dart';
import 'package:movies_app/core/models/movie_model.dart';

sealed class MovieDetailsStates {}

class MovieDetailsLoading extends MovieDetailsStates {}

class MovieDetailsSuccess extends MovieDetailsStates {
  final MovieDetailsModel movieDetails;
  final List<MovieModel> similarMovies;
  final bool isFavorite;

  MovieDetailsSuccess({
    required this.movieDetails,
    required this.similarMovies,
    required this.isFavorite,
  });

  MovieDetailsSuccess copyWith({
    MovieDetailsModel? movieDetails,
    List<MovieModel>? similarMovies,
    bool? isFavorite,
  }) {
    return MovieDetailsSuccess(
      movieDetails: movieDetails ?? this.movieDetails,
      similarMovies: similarMovies ?? this.similarMovies,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieDetailsError extends MovieDetailsStates {
  final String errorMessage;
  MovieDetailsError(this.errorMessage);
}