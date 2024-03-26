import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';

class MovieItem extends StatefulWidget {
  String imagePath;

  MovieItem({required this.imagePath});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.imagePath,
                height: 170, width: 115, fit: BoxFit.fill),
          ),
          GestureDetector(
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
    return Icon(Icons.bookmark_add, color: MyTheme.greyColor, size: 40);
  }

  clickedIcon() {
    return Icon(Icons.bookmark_added, color: MyTheme.yellowColor, size: 40);
  }
}
