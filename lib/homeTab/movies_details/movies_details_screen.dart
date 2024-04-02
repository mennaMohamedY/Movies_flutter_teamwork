// import 'package:flutter/material.dart';
// import 'package:movies_app/Themes.dart';
// import 'package:movies_app/homeTab/releases_movies/releases_movies_widget.dart';
//
// class MovieDetailsScreen extends StatefulWidget {
//   static const String routeName = 'MovieDetailsScreen';
//
//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }
//
// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var args = ModalRoute.of(context)!.settings.arguments as MovieDetails;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Movie Details',
//           style: Theme.of(context)
//               .textTheme
//               .titleLarge!
//               .copyWith(color: MyTheme.whiteColor),
//         ),
//       ),
//       body: Container(color: MyTheme.greyColor),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/homeTab/movies_details/similar_movies_widget.dart';
import 'package:movies_app/responses/MoviesDetailsResponse.dart';

import '../slider_section/video_player_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  static String routeName = "MovieDetailsScreen";

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context)?.settings.arguments as String;
    return FutureBuilder<MoviesDetailsResponse>(
      future: APIManager.getMoviesDetailsById(movieId),
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
              Text('Something Went Wrong'),
              ElevatedButton(onPressed: () {}, child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            children: [
              Text(snapshot.data?.statusMessage ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('Try Again'))
            ],
          );
        }
        var movieDetails = snapshot.data;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              movieDetails!.title!,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VideoPlayerWidget(
                    movieId: movieId.toString(),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 12, left: 12, right: 9, bottom: 5),
                      child: Text(
                        movieDetails.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 4, left: 12, right: 9, bottom: 12),
                      child: Text(
                        movieDetails.releaseDate!,
                        style: TextStyle(color: Colors.grey),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}",
                            height: MediaQuery.of(context).size.height * 0.26,
                            width: MediaQuery.of(context).size.width * 0.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  var genreList = movieDetails.genres!;
                                  return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          genreList[index].name!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ));
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: movieDetails.genres!.length,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 7),
                                child: SingleChildScrollView(
                                    child: Text(
                                  movieDetails.overview!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ))),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 12, top: 9, bottom: 9),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: CupertinoColors.systemYellow,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    movieDetails.voteAverage!
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  SimilarMoviesWidget(movieId: movieId)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
