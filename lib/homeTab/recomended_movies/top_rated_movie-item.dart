import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';

class TopRatedMovieItem extends StatefulWidget {
  String imagePath;
  String movieName;
  String movieTime;
  String movieRate;

  TopRatedMovieItem({
    required this.imagePath,
    required this.movieName,
    required this.movieRate,
    required this.movieTime,
  });

  @override
  State<TopRatedMovieItem> createState() => _TopRatedMovieItemState();
}

class _TopRatedMovieItemState extends State<TopRatedMovieItem> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: MyTheme.darkGreyColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Image.network(widget.imagePath,
                  height: 120, width: 115, fit: BoxFit.fill),
              GestureDetector(
                onTap: () {
                  // isClicked = true;
                  counter++;
                  setState(() {});
                },
                child: counter % 2 == 1 ? clickedIcon() : unClickedIcon(),
              )
            ],
          ),
          Container(
            width: 115,
            padding: EdgeInsets.only(left: 4),
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
                  style: TextStyle(color: MyTheme.lightGreyColor, fontSize: 10),
                ),
              ],
            ),
          ),
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
