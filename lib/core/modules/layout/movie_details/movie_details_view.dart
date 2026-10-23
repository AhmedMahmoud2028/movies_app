import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/modules/layout/home/poster.dart';
import 'package:movies_app/core/modules/widgets/app_badges.dart';
import 'package:movies_app/core/modules/widgets/app_button_widget.dart';
import 'package:movies_app/core/modules/widgets/cast_card.dart';
import 'package:movies_app/core/modules/widgets/screenshot_card.dart';
import 'package:movies_app/main.dart';
import '../../../configuration/gen/assets.gen.dart';
import 'movie_details_cubit.dart';
import 'movie_details_states.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  MovieModel? selectedMovie;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (selectedMovie == null) {
      selectedMovie = ModalRoute.of(context)?.settings.arguments as MovieModel?;
      if (selectedMovie != null) {
        context.read<MovieDetailsCubit>().getMovieDetails(selectedMovie!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            if (state is MovieDetailsSuccess) {
              final movie = state.movieDetails;
              final similarMovies = state.similarMovies;

              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: const ColorFilter.mode(
                        Colors.black26,
                        BlendMode.colorBurn,
                      ),
                      image: NetworkImage(movie.largeCoverImage),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Bounceable(
                              onTap: () => navigatorKey.currentState?.pop(),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.textMain,
                                size: 32,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (selectedMovie != null) {
                                  context
                                      .read<MovieDetailsCubit>()
                                      .toggleWishlist(selectedMovie!);
                                }
                              },
                              child: Icon(
                                Icons.bookmark,
                                color: state.isFavorite
                                    ? AppColors.buttonView
                                    : AppColors.textMain,
                                size: 32,
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 175.0),
                          child: Assets.icons.playIcon.svg(width: 100, height: 100),
                        ),

                        Text(
                          movie.title,
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            movie.year,
                            style: theme.textTheme.titleLarge
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        AppButtonWidget(
                          title: "Watch",
                          onTap: () {},
                          backgroundColor: AppColors.redButton,
                          titleColor: AppColors.textMain,
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppBadges(
                              icon: Assets.icons.favoriteIcon.svg(),
                              number: movie.likeCount,
                            ),
                            AppBadges(
                              icon: Assets.icons.runTimeIcon.svg(),
                              number: movie.runTime,
                            ),
                            AppBadges(
                              icon: Assets.icons.ratingIcon.svg(),
                              number: movie.rating,
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Screen Shots",
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Column(
                          spacing: 12,
                          children: [
                            ScreenshotCard(screenShot: movie.mediumScreenshotImage1),
                            ScreenshotCard(screenShot: movie.mediumScreenshotImage2),
                            ScreenshotCard(screenShot: movie.mediumScreenshotImage3),
                          ],
                        ),

                        if (similarMovies.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Similar",
                              style: theme.textTheme.headlineSmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.62,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final movieSuggest = similarMovies[index];
                              return Container(
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutesName.movieDetails,
                                      arguments: movieSuggest,
                                    );
                                  },
                                  child: Poster(
                                    imageUrl: movieSuggest.mediumCoverImage,
                                    rating: movieSuggest.rating,
                                  ),
                                ),
                              );
                            },
                            itemCount: similarMovies.length > 4 ? 4 : similarMovies.length,
                          ),
                        ],

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Summary",
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(
                          movie.descriptionFull,
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textMain,
                            fontSize: 15,
                          ),
                        ),

                        if (movie.cast.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Cast",
                              style: theme.textTheme.headlineSmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CastCard(
                                image: movie.cast[index].imageUrl,
                                name: movie.cast[index].name,
                                character: movie.cast[index].character,
                              );
                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                            itemCount: movie.cast.length,
                          ),
                        ],

                        if (movie.genres.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Genres",
                              style: theme.textTheme.headlineSmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.textFormFill,
                                ),
                                child: Center(
                                  child: Text(
                                    movie.genres[index],
                                    style: theme.textTheme.titleLarge
                                        ?.copyWith(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                            itemCount: movie.genres.length,
                          ),
                        ],
                      ],
                    ),
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