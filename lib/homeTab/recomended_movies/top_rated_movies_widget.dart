import 'package:flutter/material.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/homeTab/recomended_movies/top_rated_movie-item.dart';
import 'package:movies_app/responses/TopRatedMoviesResponse.dart';

import '../../Themes.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  @override
  State<TopRatedMoviesWidget> createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopRatedMoviesResponse>(
      future: APIManager.getTopRatedMovies(),
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
                    APIManager.getTopRatedMovies();
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
                    APIManager.getTopRatedMovies();
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        var topRatedList = snapshot.data!.results ?? [];
        return Container(
          padding: EdgeInsets.all(5),
          color: MyTheme.greyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recomended',
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
                          movieId: topRatedList[index].id.toString(),
                          movieName: topRatedList[index].originalTitle!,
                          movieRate: topRatedList[index]
                              .voteAverage!
                              .toStringAsFixed(1),
                          movieTime: topRatedList[index].releaseDate!,
                          imagePath:
                              "https://image.tmdb.org/t/p/w500/${topRatedList[index].posterPath}"),
                    );
                  },
                  itemCount: 20,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
