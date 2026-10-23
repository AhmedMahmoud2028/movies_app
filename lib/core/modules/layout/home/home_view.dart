import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/modules/layout/home/poster.dart';
import '../../../../main.dart';
import '../../../configuration/gen/assets.gen.dart';
import '../../../configuration/routes/app_routes_name.dart';
import '../../data/genres_data.dart';
import '../../widgets/movie_genre_section.dart';
import 'movie_cubit/movie_cubit.dart';
import 'movie_cubit/movie_states.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _moviesList = GenresData.genresList;
  late PageController pageController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.55,
    );

    context.read<MovieCubit>().getAllMovies(_moviesList[0].name);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: BlocBuilder<MovieCubit, MovieStates>(
          builder: (context, state) {
            if (state is LoadingGetAllMovie) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorGetAllMovie) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (state is SuccessGetAllMovie) {
              final movies = state.movieList;

              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    "There aren't movies available right now.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final safeIndex = currentPage < movies.length ? currentPage : 0;

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                      Colors.black45,
                      BlendMode.colorBurn,
                    ),
                    image: NetworkImage(movies[safeIndex].largeCoverImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 16,
                        ),
                        child: Assets.images.availableNow.image(),
                      ),

                      /// Carousel Section
                      SizedBox(
                        height: 320,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: movies.length,
                          onPageChanged: (int index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return AnimatedBuilder(
                              animation: pageController,
                              builder: (context, child) {
                                double value = 0.0;
                                if (pageController.position.haveDimensions) {
                                  value = index - (pageController.page ?? 0);
                                  value = (value * 0.25);
                                } else {
                                  value = (index == currentPage) ? 0 : 0.25;
                                }

                                final double scale =
                                (1 - value.abs()).clamp(0.0, 1.0);

                                return Transform.scale(
                                  scale: scale,
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutesName.movieDetails,
                                    arguments: movie,
                                  );
                                },
                                child: Poster(
                                  imageUrl: movie.mediumCoverImage,
                                  rating: movie.rating,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        child: Assets.images.watchNow.image(),
                      ),

                      /// Sections by Genre
                      MovieGenreSection(
                        genreName: _moviesList[0].name,
                        theme: theme,
                      ),
                      const SizedBox(height: 30),
                      MovieGenreSection(
                        genreName: _moviesList[1].name,
                        theme: theme,
                      ),
                      const SizedBox(height: 30),
                      MovieGenreSection(
                        genreName: _moviesList[2].name,
                        theme: theme,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}