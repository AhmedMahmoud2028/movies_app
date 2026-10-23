import 'package:bloc/bloc.dart';
import 'package:movies_app/core/network/http_requests_service.dart';
import 'package:movies_app/core/modules/layout/home/movie_cubit/movie_states.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(LoadingGetAllMovie());

  Future<void> getAllMovies(String genre) async {
    emit(LoadingGetAllMovie());

    try {
      final moviesList = await HttpRequestsService.getAllMovies(genre);

      emit(SuccessGetAllMovie(moviesList));
    } catch (e) {
      emit(ErrorGetAllMovie(e.toString()));
    }
  }
}