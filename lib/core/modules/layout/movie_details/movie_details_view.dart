import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/models/movie_details_model.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/modules/layout/home/poster.dart';
import 'package:movies_app/core/modules/widgets/app_badges.dart';
import 'package:movies_app/core/modules/widgets/app_button_widget.dart';
import 'package:movies_app/core/modules/widgets/cast_card.dart';
import 'package:movies_app/core/modules/widgets/screenshot_card.dart';
import 'package:movies_app/main.dart';
import '../../../configuration/gen/assets.gen.dart';
import '../../../network/http_requests_service.dart';
import '../../../service/snack_bar_service.dart';
import '../../../service/wishlist_service.dart';



class MovieDetailsView extends StatefulWidget {

  const MovieDetailsView({super.key,});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedMovie = ModalRoute.of(context)?.settings.arguments as MovieModel?; /// Important ***
    final movieId = int.tryParse(selectedMovie!.id) ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
          child: FutureBuilder<MovieDetailsModel?>(
              future: HttpRequestsService.getMovieDetails(movieId),
              builder: (context,snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center( child: CircularProgressIndicator(),);}

                if (snapshot.hasError) {
                  SnackBarService.showErrorMessage("Error: ${snapshot.error}");

                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Scaffold(
                      backgroundColor: Color(0xFF121312),
                      body: Center(
                          child: Text(
                              "Sorry, there are no details available for this movie.",
                              style: TextStyle(color: Colors.white, fontSize: 16),),),);

                }
                final movie = snapshot.data!;

                return SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
                              image: NetworkImage(movie.largeCoverImage),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Bounceable(onTap:(){
                                    navigatorKey.currentState?.pop();
                                  },child: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.textMain,size: 32,)),
                                  Spacer(),
                                  GestureDetector(onTap:() async {
                                    await WishlistService.toggleWishlist({
                                      'id': selectedMovie.id,
                                      'title': selectedMovie.title,
                                      'rating': selectedMovie.rating,
                                      'medium_cover_image': selectedMovie.mediumCoverImage,
                                    });

                                      setState(() {
                                        selectedMovie.isFavorite = !selectedMovie.isFavorite;
                                      });
                                    },child: Icon(Icons.bookmark,
                                    color: selectedMovie.isFavorite?AppColors.buttonView : AppColors.textMain ,size: 32,))
                                ],),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 175.0),
                                child: Assets.icons.playIcon.svg(width: 100,height: 100),
                              ),

                              /// Very Important : Now We can put any Text In Center
                              Text(movie.title,
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),textAlign: TextAlign.center,),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(movie.year,style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey,),textAlign: TextAlign.center,),
                              ),

                              AppButtonWidget(
                                title: "Watch",
                                onTap: (){},
                                backgroundColor: AppColors.redButton,
                                titleColor: AppColors.textMain,),

                              SizedBox(height: 16,),

                              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppBadges(icon: Assets.icons.favoriteIcon.svg(), number: movie.likeCount),
                                  AppBadges(icon: Assets.icons.runTimeIcon.svg(), number: movie.runTime),
                                  AppBadges(icon: Assets.icons.ratingIcon.svg(), number: movie.rating )
                                ],),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Screen Shots",style: theme.textTheme.headlineSmall,textAlign: TextAlign.start,),
                              ),
                              Column(
                                spacing: 12,
                                children: [
                                  ScreenshotCard(screenShot: movie.mediumScreenshotImage1),
                                  ScreenshotCard(screenShot: movie.mediumScreenshotImage2),
                                  ScreenshotCard(screenShot: movie.mediumScreenshotImage3)
                                ],),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Similar",style: theme.textTheme.headlineSmall,textAlign: TextAlign.start,),),

                              FutureBuilder<List<MovieModel>>(
                                future: HttpRequestsService.getMovieSuggestions(movieId),
                                builder: (context,snapshot) {

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center( child: CircularProgressIndicator(),); }

                                  if (snapshot.hasError) {
                                    SnackBarService.showErrorMessage("${snapshot.error}"); }

                                  if (!snapshot.hasData ) {
                                    SnackBarService.showErrorMessage(
                                        "Sorry, there are no details available for this movie."); }

                                  final movieSuggestions = snapshot.data!;

                                  return GridView.builder(
                                    /// Very Important for any List/Grid View.
                                    physics: NeverScrollableScrollPhysics(),
                                    /// Very Important for any List/Grid View.
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.62,
                                        crossAxisSpacing: 18,
                                        mainAxisSpacing: 12 ),
                                    itemBuilder: (context, index) {
                                      final movieSuggest = movieSuggestions[index];
                                      return Container(
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: GestureDetector(onTap:(){
                                          navigatorKey.currentState?.pushNamed(AppRoutesName.movieDetails,arguments: movieSuggest);
                                        },child: Poster(imageUrl: movieSuggest.mediumCoverImage,rating: movieSuggest.rating,)),
                                      );
                                    },
                                    itemCount: 4);

                                },),










                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Summary",style: theme.textTheme.headlineSmall,textAlign: TextAlign.start,),
                              ),
                              Text(movie.descriptionFull,textAlign: TextAlign.start,style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textMain,fontSize: 15),),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Cast",style: theme.textTheme.headlineSmall,textAlign: TextAlign.start,),),
                              ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,

                                  itemBuilder: (context,index){
                                    return CastCard(image: movie.cast[index].imageUrl,name: movie.cast[index].name,character: movie.cast[index].character);
                                  },
                                  separatorBuilder: (context,index){
                                    return SizedBox(height: 8);
                                  },
                                  itemCount: movie.cast.length),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Genres",style: theme.textTheme.headlineSmall,textAlign: TextAlign.start,),),
                              GridView.builder(
                                /// Very Important for any List/Grid View.
                                physics: NeverScrollableScrollPhysics(),
                                /// Very Important for any List/Grid View.
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10 ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.textFormFill
                                      ),
                                      child: Center(child: Text(movie.genres[index],style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),))
                                  );
                                },
                                itemCount: movie.genres.length,),
                            ]),)
                  ),
                );
              })
      ),

    );
  }
}
