import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/api/VideosResponse.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchItemDetails extends StatefulWidget {
  static const String routeName = 'searchItemDetails';

  @override
  State<SearchItemDetails> createState() => _SearchItemDetailsState();
}

class _SearchItemDetailsState extends State<SearchItemDetails> {
  late YoutubePlayerController _controller;
  String? url;

  @override
  void initState() {
    _controller = YoutubePlayerController(initialVideoId: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
        appBar: AppBar(
            title: Text(movie.title ?? ''),
            backgroundColor: MyTheme.sectionsGrey),
        body: Column(
          children: [
            FutureBuilder<VideosResponse?>(
                future: ApiManager.getMovieVideo(
                    endPoint: '/3/movie/${movie.id}/videos'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        Text('Network problem',
                            style: TextStyle(color: Colors.white)),
                        ElevatedButton(
                            onPressed: () {
                              ApiManager.getMovies();
                              setState(() {});
                            },
                            child: Text('Try Again',
                                style: TextStyle(color: Colors.white)))
                      ],
                    );
                  }
                  if (snapshot.data?.success == false) {
                    return Column(
                      children: [
                        Text(snapshot.data!.status_message ?? '',
                            style: TextStyle(color: Colors.white)),
                        ElevatedButton(
                            onPressed: () {
                              ApiManager.getMovies();
                              setState(() {});
                            },
                            child: Text('Try Again'))
                      ],
                    );
                  }
                  var trailers = snapshot.data?.results ?? [];
                  String? key;
                  for (int i = 0; i < trailers.length; i++) {
                    if (trailers[i].official == true) {
                      key = trailers[i].key ??= '';
                    }
                  }
                  _controller =
                      YoutubePlayerController(initialVideoId: key ?? '');

                  return Column(children: [
                    YoutubePlayerBuilder(
                        player: YoutubePlayer(controller: _controller),
                        builder: (context, player) {
                          return YoutubePlayer(controller: _controller);
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              movie.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              movie.releaseDate ?? '',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                        child: Image.network(
                                            'https://image.tmdb.org/t/p/w92${movie.posterPath}'),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    Image.asset(
                                        'assets/images/bookmark (1).png')
                                  ],
                                ),
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                )
                              ],
                            )
                          ]),
                    )
                  ]);
                })
          ],
        ));
  }
}
