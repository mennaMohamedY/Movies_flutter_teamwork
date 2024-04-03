import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/firebase/firebase_utils.dart';
import 'package:provider/provider.dart';

import '../../provider/app_config_provider.dart';
import '../../responses/ReleasesMoviesResponse.dart';
import '../movies_details/movies_details_screen.dart';

class MovieItem extends StatefulWidget {
  Results movie;
  String movieId;
  String imagePath;
  double height;

  MovieItem(
      {required this.imagePath,
      required this.movieId,
      required this.height,
      required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  int counter = 0;
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailsScreen.routeName,
            arguments: widget.movieId);
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.imagePath,
                height: widget.height, width: 115, fit: BoxFit.fill),
          ),
          InkWell(
            onTap: () {
              counter++;
              setState(() {});
            },
            child: counter % 2 == 1 ? clickedIcon() : unClickedIcon(),
          )
        ],
      ),
    );
  }

  unClickedIcon() {
    return Icon(
      Icons.bookmark_add,
      color: MyTheme.greyColor,
      size: 40,
    );
  }

  clickedIcon() {
    FirebaseUtils.setMovieToFirestore(widget.movie);
    provider.getMoviesFromFireStore();
    return Icon(
      Icons.bookmark_added,
      color: MyTheme.yellowColor,
      size: 40,
    );
  }
}
