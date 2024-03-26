import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/homeTab/releases_movies/movie-item.dart';
import 'package:movies_app/responses/PopularMoviesResponse.dart';

class PopularMoviesWidget extends StatefulWidget {
  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  // YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'iLnmTe5Q2Qw',
  //   flags: YoutubePlayerFlags(autoPlay: true, mute: true),
  // );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMoviesResponse>(
      future: APIManager.getPopularMovies(),
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
        var resultsList = snapshot.data?.results ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Column(
                children: [
                  // YoutubePlayer(
                  //   controller: _controller,
                  //   showVideoProgressIndicator: true,
                  //   progressIndicatorColor: Colors.amber,
                  //   progressColors: const ProgressBarColors(
                  //     playedColor: Colors.amber,
                  //     handleColor: Colors.amberAccent,
                  //   ),
                  // ),
                  Container(
                    height: 200,
                    color: MyTheme.greyColor,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      'Slider',
                      style: TextStyle(fontSize: 35),
                    )),
                  ),
                  SizedBox(height: 5),

                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Movie title',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: MyTheme.whiteColor),
                          ),
                          Text(
                            'Movie Released Date',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.lightGreyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: MovieItem(
                    imagePath:
                        'https://image.tmdb.org/t/p/w500/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg'),
              )
            ]),
          ],
        );
      },
    );
  }
}
