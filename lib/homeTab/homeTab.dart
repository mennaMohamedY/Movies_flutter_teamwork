import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/homeTab/recomended_movies/top_rated_movies_widget.dart';
import 'package:movies_app/homeTab/releases_movies/releases_movies_widget.dart';
import 'package:movies_app/homeTab/slider_section/popular_movies_widget.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.blackColor,
      child: ListView(
        children: [
          PopularMoviesWidget(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ReleasesMoviesWidget(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TopRatedMoviesWidget()
        ],
      ),
    );
  }
}
