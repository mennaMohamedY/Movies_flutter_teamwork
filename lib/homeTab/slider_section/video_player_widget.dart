import 'package:flutter/material.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/responses/MovieTrailersResponse.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Themes.dart';

class VideoPlayerWidget extends StatefulWidget {
  String movieId;

  VideoPlayerWidget({required this.movieId});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieTrailersResponse>(
      future: APIManager.getMovieTrailers(widget.movieId),
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
              ElevatedButton(
                  onPressed: () {
                    APIManager.getMovieTrailers(widget.movieId);
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            children: [
              Text(snapshot.data?.status_message ?? ''),
              ElevatedButton(
                  onPressed: () {
                    APIManager.getMovieTrailers(widget.movieId);
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
        _controller = YoutubePlayerController(initialVideoId: key ?? '');
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _controller),
                  builder: (context, player) {
                    return YoutubePlayer(controller: _controller);
                  })
            ]);
      },
    );
  }
}
