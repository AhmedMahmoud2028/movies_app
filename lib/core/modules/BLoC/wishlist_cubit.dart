import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/modules/BLoC/wishlist_states.dart';

import '../../models/movie_model.dart';

class WishlistCubit extends Cubit<WishlistStates> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? _wishlistSubscription;

  WishlistCubit() : super(WishlistInitial());

  // الاستماع المباشر لـ Firestore عبر Stream
  void fetchWishlist() {
    emit(WishlistLoading());
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      emit(const WishlistError("User not logged in"));
      return;
    }

    _wishlistSubscription?.cancel(); // إلغاء أي اشتراك سابق
    _wishlistSubscription = _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .snapshots()
        .listen(
          (snapshot) {
        final movies = snapshot.docs
            .map((doc) => MovieModel.fromJson(doc.data()))
            .toList();
        emit(WishlistLoaded(movies));
      },
      onError: (error) {
        emit(WishlistError(error.toString()));
      },
    );
  }

  // إضافة أو حذف فيلم من المفضلة
  Future<void> toggleWishlist(MovieModel movie) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(movie.id.toString());

    try {
      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.delete();
      } else {
        await docRef.set(movie.toJson());
      }
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  // التأكد من معرفة هل الفيلم مضاف مسبقاً أم لا (لإضاءة الأيقونة)
  bool isFavorite(int movieId) {
    if (state is WishlistLoaded) {
      final movies = (state as WishlistLoaded).wishlistMovies;
      return movies.any((m) => m.id == movieId as String);
    }
    return false;
  }

  @override
  Future<void> close() {
    _wishlistSubscription?.cancel();
    return super.close();
  }
}