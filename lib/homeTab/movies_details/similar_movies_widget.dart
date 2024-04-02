import 'package:flutter/material.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/homeTab/recomended_movies/top_rated_movie-item.dart';
import 'package:movies_app/responses/SimilarMoviesResponse.dart';

import '../../Themes.dart';

class SimilarMoviesWidget extends StatefulWidget {
  String movieId;

  SimilarMoviesWidget({required this.movieId});

  @override
  State<SimilarMoviesWidget> createState() => _SimilarMoviesWidgetState();
}

class _SimilarMoviesWidgetState extends State<SimilarMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SimilarMoviesResponse>(
      future: APIManager.getSimilarMoviesById(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: MyTheme.yellowColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something Went Wrong',
                  style: TextStyle(color: MyTheme.whiteColor)),
              ElevatedButton(
                  onPressed: () {
                    APIManager.getSimilarMoviesById(widget.movieId);
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            children: [
              Text(snapshot.data?.statusMessage ?? '',
                  style: TextStyle(color: MyTheme.whiteColor)),
              ElevatedButton(
                  onPressed: () {
                    APIManager.getSimilarMoviesById(widget.movieId);
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        var similarMoviesList = snapshot.data!.results ?? [];
        if (similarMoviesList.isNotEmpty) {
          return Container(
            padding: EdgeInsets.all(5),
            color: MyTheme.greyColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'More Like This',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  margin: EdgeInsets.only(top: 4),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        // onTap: () {
                        //   Navigator.pushNamed(
                        //       context, MovieDetailsScreen.routeName,
                        //       arguments:
                        //           MovieDetails(results: topRatedList[index]));
                        // },
                        child: TopRatedMovieItem(
                            movie: similarMoviesList[index],
                            movieId: similarMoviesList[index].id.toString(),
                            movieName: similarMoviesList[index].originalTitle!,
                            movieRate: similarMoviesList[index]
                                .voteAverage!
                                .toStringAsFixed(1),
                            movieTime: similarMoviesList[index].releaseDate!,
                            imagePath:
                                "https://image.tmdb.org/t/p/w500/${similarMoviesList[index].posterPath ?? 'Y5P4Q3q8nrruZ9aD3wXeJS2Plg.jpg'}"),
                      );
                    },
                    itemCount: similarMoviesList
                        .length, // Use the actual length of the list
                  ),
                )
              ],
            ),
          );
        } else {
          // Handle the case when similarMoviesList is empty
          return Container(
            height: 100,
            child: Center(
              child: Text('No similar movies found',
                  style: TextStyle(color: MyTheme.whiteColor)),
            ),
          );
          // var similarMoviesList = snapshot.data!.results ?? [];
          // return Container(
          //   padding: EdgeInsets.all(5),
          //   color: MyTheme.greyColor,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'More Like This',
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.23,
          //         margin: EdgeInsets.only(top: 4),
          //         child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemBuilder: (context, index) {
          //             return TopRatedMovieItem(
          //                 movieId: similarMoviesList[index].id.toString(),
          //                 movieName: similarMoviesList[index].originalTitle!,
          //                 movieRate: similarMoviesList[index]
          //                     .voteAverage!
          //                     .toStringAsFixed(1),
          //                 movieTime: similarMoviesList[index].releaseDate!,
          //                 imagePath:
          //                     "https://image.tmdb.org/t/p/w500/${similarMoviesList[index].posterPath ?? 'Y5P4Q3q8nrruZ9aD3wXeJS2Plg.jpg'}");
          //           },
          //           itemCount: 20,
          //         ),
          //       )
          //     ],
          //   ),
          // );
        }
      },
    );
  }
}
