import 'package:bloc/bloc.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/network/http_requests_service.dart';
import 'package:movies_app/core/service/wishlist_service.dart';
import '../../../models/movie_details_model.dart';
import 'movie_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieDetailsLoading());

  Future<void> getMovieDetails(MovieModel selectedMovie) async {
    emit(MovieDetailsLoading());
    try {
      final movieId = int.tryParse(selectedMovie.id) ?? 0;

      final results = await Future.wait([
        HttpRequestsService.getMovieDetails(movieId),
        HttpRequestsService.getMovieSuggestions(movieId),
      ]);

      final movieDetails = results[0] as MovieDetailsModel?;
      final similarMovies = results[1] as List<MovieModel>? ?? [];

      if (movieDetails == null) {
        emit(MovieDetailsError("Sorry, there are no details available for this movie."));
        return;
      }

      emit(MovieDetailsSuccess(
        movieDetails: movieDetails,
        similarMovies: similarMovies,
        isFavorite: selectedMovie.isFavorite,
      ));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }

  Future<void> toggleWishlist(MovieModel selectedMovie) async {
    if (state is MovieDetailsSuccess) {
      final currentState = state as MovieDetailsSuccess;
      final newFavoriteStatus = !currentState.isFavorite;

      emit(currentState.copyWith(isFavorite: newFavoriteStatus));
      selectedMovie.isFavorite = newFavoriteStatus;

      await WishlistService.toggleWishlist({
        'id': selectedMovie.id,
        'title': selectedMovie.title,
        'rating': selectedMovie.rating,
        'medium_cover_image': selectedMovie.mediumCoverImage,
      });
    }
  }
}