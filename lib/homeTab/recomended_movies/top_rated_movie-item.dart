import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/firebase/firebase_utils.dart';
import 'package:movies_app/homeTab/releases_movies/movie-item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_config_provider.dart';
import '../../responses/ReleasesMoviesResponse.dart';

class TopRatedMovieItem extends StatefulWidget {
  String imagePath;
  String movieId;
  String movieName;
  String movieTime;
  String movieRate;
  Results movie;

  TopRatedMovieItem(
      {required this.imagePath,
      required this.movieId,
      required this.movieName,
      required this.movieRate,
      required this.movieTime,
      required this.movie});

  @override
  State<TopRatedMovieItem> createState() => _TopRatedMovieItemState();
}

class _TopRatedMovieItemState extends State<TopRatedMovieItem> {
  int counter = 0;
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: MyTheme.darkGreyColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieItem(
                movie: widget.movie,
                height: 130,
                imagePath: widget.imagePath,
                movieId: widget.movieId),
            Container(
              width: 115,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: MyTheme.yellowColor, size: 18),
                      SizedBox(width: 4),
                      Text('${widget.movieRate}',
                          style: TextStyle(
                            color: MyTheme.whiteColor,
                          ))
                    ],
                  ),
                  Text(
                    widget.movieName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: MyTheme.whiteColor),
                  ),
                  Text(
                    widget.movieTime,
                    style:
                    TextStyle(color: MyTheme.lightGreyColor, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
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
