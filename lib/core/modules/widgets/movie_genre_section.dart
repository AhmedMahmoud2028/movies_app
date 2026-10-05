import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/main.dart';

import '../../configuration/theme/app_colors.dart';
import '../../models/movie_model.dart';
import '../../network/http_requests_service.dart';

class MovieGenreSection extends StatefulWidget {
  final String genreName;
  final ThemeData theme;

  const MovieGenreSection({
    super.key,
    required this.genreName,
    required this.theme,
  });

  @override
  State<MovieGenreSection> createState() => _MovieGenreSectionState();
}

class _MovieGenreSectionState extends State<MovieGenreSection> {
  late Future<List<MovieModel>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = HttpRequestsService.getAllMovies(widget.genreName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(widget.genreName, style: widget.theme.textTheme.titleLarge),
              const Spacer(),
              Text(
                "See More ",
                style: widget.theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.buttonView,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.arrow_forward, color: AppColors.buttonView, size: 14),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<MovieModel>>(
          future: _moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox.shrink();
            }

            final movies = snapshot.data!;

            return SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(onTap: (){
                    navigatorKey.currentState?.pushNamed(AppRoutesName.movieDetails,arguments: movie);
                  }, child: Stack(
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(movie.mediumCoverImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  movie.rating.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}