import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/modules/data/genres_data.dart';
import 'package:movies_app/core/modules/layout/home/poster.dart';
import 'package:movies_app/core/network/http_requests_service.dart';
import 'package:movies_app/main.dart';

import '../../../service/snack_bar_service.dart';


class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {

  int _selectedIndex = 0;
  final _moviesList = GenresData.genresList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(children: [
       Padding(
         padding: const EdgeInsets.only(top: 32.0,bottom: 24),
         child: SizedBox(
             height: 50,
             child: ListView.separated(
                 /// This padding working well with same scrollDirection.
                 /// In this Case not Working with vertical.
                 padding: EdgeInsets.symmetric(horizontal: 16),
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context,index){
                  final isSelected = _selectedIndex == index; /// Important
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         _selectedIndex = index;


                       });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         color: isSelected ? AppColors.buttonView : AppColors.primary,
                         borderRadius: BorderRadius.circular(16),
                         border: Border.all(color: AppColors.buttonView,width: 2)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                         child: Center(child: Text(_moviesList[index].name,style: theme.textTheme.titleLarge?.copyWith(
                             color: isSelected ? AppColors.primary : AppColors.buttonView),)),
                       ),
                     ),
                   );
                 },
                 separatorBuilder: (context,index){
                   return SizedBox(width: 10);
                 },
                 itemCount: _moviesList.length),
           ),
       ),
        SizedBox(height: 5,),

        Expanded(child: FutureBuilder<List<MovieModel>>(
            future: HttpRequestsService.getAllMovies(_moviesList[_selectedIndex].name),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                SnackBarService.showErrorMessage("${snapshot.error}");
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                SnackBarService.showErrorMessage("There aren't movies available for this genre.");

              }
              final movies = snapshot.data!;

              return  Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.62,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 12
                    ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector( onTap:(){
                      navigatorKey.currentState?.pushNamed(AppRoutesName.movieDetails,arguments: movie);
                      },child: Poster(rating: movie.rating, imageUrl: movie.mediumCoverImage));

                    },
                    itemCount: movies.length,

                  ),
              );
            }
            )
          ),

      ]),
    );
  }
}
