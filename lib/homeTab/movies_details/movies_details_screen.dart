import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/homeTab/releases_movies/releases_movies_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = 'MovieDetailsScreen';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as MovieDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyTheme.whiteColor),
        ),
      ),
      body: Container(color: MyTheme.greyColor),
    );
  }
}
