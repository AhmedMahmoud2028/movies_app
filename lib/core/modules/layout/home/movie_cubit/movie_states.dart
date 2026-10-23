

import 'package:movies_app/core/models/movie_model.dart';

sealed class MovieStates {}

class LoadingGetAllMovie extends MovieStates {
}

class SuccessGetAllMovie extends MovieStates {
  final List<MovieModel> movieList;
  SuccessGetAllMovie(this.movieList);
}

class ErrorGetAllMovie extends MovieStates {
  final String errorMessage;
  ErrorGetAllMovie(this.errorMessage);


}

