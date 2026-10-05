import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/models/movie_details_model.dart';
import '../models/movie_model.dart';
import 'app_constants.dart';
import 'end_points.dart';

class HttpRequestsService {

  HttpRequestsService._();

  static Future<List<MovieModel>> getAllMovies(String genreName) async {
    /// we need tool to fetch or bring data from network
    /// download package "http"
    /// add the Internet permission to AndroidManifest.xml file.
    try {
    final Map<String, dynamic> queryParameters = {
      "genre": genreName
    };
    /// Domain = authority
    /// endpoint = unencodedPath
    final response = await http.get(
        Uri.https(AppConstants.baseURL, EndPoints.listMovies, queryParameters));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      final rawMovies = decodedData["data"]?["movies"] ?? decodedData["movies"];

      if (rawMovies == null || rawMovies is! List) {
        return [];
      }

      List<MovieModel> movies = [];

      for (var source in rawMovies) {
        if (source != null) {
          movies.add(MovieModel.fromJson(source));
        }
      }
      return movies;
    } else {
      return [];
    }
  } catch (e){
      rethrow;
    }
  }

  /// ---------------------------------------- ///

  static Future<MovieDetailsModel?> getMovieDetails (int movieID) async {

    try {
      final Map<String, dynamic> queryParameters = {

        /// notes: It Must be String & String to working well.

        "movie_id": movieID.toString(),
        "with_images": "true",
        "with_cast": "true",

      };
      final response = await http.get(
        Uri.https(AppConstants.baseURL,EndPoints.movieDetails,queryParameters));

      if(response.statusCode == 200)
      {
        final decodedData = jsonDecode(response.body);

        final movie = decodedData["data"]?["movie"];





        if(movie != null)
        {
          return MovieDetailsModel.fromJson(movie);
        }
      }

      /// Important Handle Null Case
      return null;

    } catch (e) {
      rethrow;
    }
  }


  /// ---------------------------------------- ///

  static Future<List<MovieModel>> getMovieSuggestions (int movieID) async {

    try {
      final Map<String, dynamic> queryParameters = {
        /// notes: It Must be String & String to working well.
        "movie_id": movieID.toString(),
      };

      final response = await http.get(
          Uri.https(AppConstants.baseURL,EndPoints.movieSuggestions,queryParameters));

      if(response.statusCode == 200)
      {
        final decodedData = jsonDecode(response.body);
        final rawMovies = decodedData["data"]?["movies"] ?? decodedData["movies"];

        if (rawMovies == null || rawMovies is! List) {
          return [];
        }

        List<MovieModel> movies = [];

        for (var movie in rawMovies) {
          if (movie != null) {
            movies.add(MovieModel.fromJson(movie));
          }
        }
        return movies;
      } else {
        return [];
      }
    } catch (e){
      rethrow;
    }
  }


}








