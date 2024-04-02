import 'package:flutter/material.dart';
import 'package:movies_app/homeTab/releases_movies/movie-item.dart';
import 'package:movies_app/responses/ReleasesMoviesResponse.dart';

import '../../Themes.dart';
import '../../api_manager/apimanager.dart';

class ReleasesMoviesWidget extends StatefulWidget {
  @override
  State<ReleasesMoviesWidget> createState() => _ReleasesMoviesWidgetState();
}

class _ReleasesMoviesWidgetState extends State<ReleasesMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReleasesMoviesResponse>(
      future: APIManager.getReleasesMovies(),
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
                    APIManager.getReleasesMovies();
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            children: [
              Text(
                snapshot.data?.statusMessage ?? '',
                style: TextStyle(color: MyTheme.whiteColor),
              ),
              ElevatedButton(
                  onPressed: () {
                    APIManager.getReleasesMovies();
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        var releasesList = snapshot.data!.results ?? [];
        return Container(
          padding: EdgeInsets.all(5),
          color: MyTheme.greyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Releases',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.180,
                margin: EdgeInsets.only(top: 4),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(6),
                      child: MovieItem(
                          movieId: releasesList[index].id.toString(),
                          height: 170,
                          imagePath:
                              "https://image.tmdb.org/t/p/w500/${releasesList[index].posterPath}"),
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

class MovieDetails {
  Results results;

  MovieDetails({required this.results});
}
