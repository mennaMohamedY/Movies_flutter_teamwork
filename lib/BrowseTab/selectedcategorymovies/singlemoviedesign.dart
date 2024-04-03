import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/firebase/firebase_utils.dart';
import 'package:movies_app/responses/SelectedCategoryMoviesResponse.dart';

import '../../homeTab/movies_details/movies_details_screen.dart';
import '../../responses/ReleasesMoviesResponse.dart';

class SingleMovieDesign extends StatefulWidget {
  String movieId;

  //MoviesDataModel movie;
  Results movie;



  SingleMovieDesign({required this.movie, required this.movieId});

  @override
  State<SingleMovieDesign> createState() => _SingleMovieDesignState();
}

class _SingleMovieDesignState extends State<SingleMovieDesign> {
  bool saved = false;
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    //Movie moviee=widget.movie as Movie;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailsScreen.routeName,
            arguments: widget.movieId);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            color: Color(0xff333433),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Color(0x5E1C1B1B),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                ),
                IconButton(
                  icon: (saved)
                      ? Icon(
                          Icons.bookmark_added_sharp,
                          color: CupertinoColors.systemYellow,
                          size: 35,
                        )
                      : Icon(
                          Icons.bookmark_added_outlined,
                          color: Color(0xC9C4C4FF),
                          size: 35,
                        ),
                  onPressed: () {
                    onSaveClickListener();
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, left: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: CupertinoColors.systemYellow,
                  ),
                  Text(
                    '${widget.movie.voteAverage}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 7, top: 3),
                child: Text(
                  widget.movie.title ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            Padding(
                padding: EdgeInsets.only(left: 9, top: 3),
                child: Text(
                  "${widget.movie.releaseDate}",
                  style: TextStyle(color: Color(0xFF88888A)),
                ))
          ]),
        ),
      ),
    );
  }

  void onSaveClickListener() {
    if (counter % 2 == 0) {
      saved = true;
      FirebaseUtils.setMovieToFirestore(widget.movie);
    } else {
      saved = false;
    }
    counter++;
    setState(() {});
  }
}

/*
Image.asset("assets/images/m2.JPG",
              height: MediaQuery.of(context).size.height*0.14,
              width: MediaQuery.of(context).size.width*0.5,
              fit: BoxFit.fill,

            )
 */
/*
CachedNetworkImage(
            ///kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg",
            //${widget.movie.posterPath}
              imageUrl: "https://image.tmdb.org/t/p/w500/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg",
              placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
 */
