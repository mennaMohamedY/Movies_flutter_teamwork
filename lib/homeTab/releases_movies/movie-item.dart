import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';

import '../movies_details/movies_details_screen.dart';

class MovieItem extends StatefulWidget {
  String movieId;
  String imagePath;
  double height;

  MovieItem(
      {required this.imagePath, required this.movieId, required this.height});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
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
    return Icon(
      Icons.bookmark_added,
      color: MyTheme.yellowColor,
      size: 40,
    );
  }
}
