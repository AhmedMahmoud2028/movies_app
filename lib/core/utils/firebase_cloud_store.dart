import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/models/movie_model.dart';

abstract class FirebaseCloudStore {


  static CollectionReference<MovieModel> _getCollectionReference(){       /// two sides of the same coin
    return FirebaseFirestore.instance.
    collection(MovieModel.collectionName).
    withConverter<MovieModel>(
        fromFirestore: ((snapshot, options) => MovieModel.fromJson(snapshot.data()!)),   /// Named Constructor
        toFirestore: ( movieModel , options) => movieModel.toJson()                       /// Function
    );
  }

  static Future<bool> updateEvent (MovieModel movieModel) async {
    try{
      await _getCollectionReference().doc(movieModel.id).update(movieModel.toJson());
      return Future.value(true);
    }
    catch(error){
      return Future.value(false);
    }
  }

}