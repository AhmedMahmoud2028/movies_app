import 'package:equatable/equatable.dart';

import '../../models/movie_model.dart';

abstract class WishlistStates extends Equatable {
  const WishlistStates();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistStates {}

class WishlistLoading extends WishlistStates {}

class WishlistLoaded extends WishlistStates {
  final List<MovieModel> wishlistMovies;

  const WishlistLoaded(this.wishlistMovies);

  @override
  List<Object?> get props => [wishlistMovies];
}

class WishlistError extends WishlistStates {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}