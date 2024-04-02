import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/homeTab/releases_movies/movie-item.dart';
import 'package:movies_app/homeTab/slider_section/video_player_widget.dart';
import 'package:movies_app/responses/PopularMoviesResponse.dart';

class PopularMoviesWidget extends StatefulWidget {
  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
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
              ElevatedButton(
                  onPressed: () {
                    APIManager.getPopularMovies();
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            children: [
              Text(snapshot.data?.statusMessage ?? ''),
              ElevatedButton(
                  onPressed: () {
                    APIManager.getPopularMovies();
                    setState(() {});
                  },
                  child: Text('Try Again'))
            ],
          );
        }
        var resultsList = snapshot.data?.results ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3 / 1,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 20),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height * 0.33,
              ),
              items: resultsList.map((movie) {
                return Builder(builder: (BuildContext context) {
                  int index = resultsList.indexOf(movie);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: MyTheme.darkBlackColor),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              VideoPlayerWidget(
                                movieId: resultsList[index].id.toString(),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          resultsList[index].title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: MyTheme.whiteColor),
                                        ),
                                      ),
                                      Text(
                                        resultsList[index].releaseDate!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: MyTheme.lightGreyColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: MovieItem(
                            movieId: resultsList[index].id.toString(),
                            height: 170,
                            imagePath:
                                'https://image.tmdb.org/t/p/w500/${resultsList[index].posterPath}',
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }).toList(),
              // items: resultsList.map((movie) {
              //   return Builder(builder: (BuildContext context) {
              //     int index = resultsList.indexOf(movie);
              //     return
              //
              //     //   Container(
              //     //   width: MediaQuery.of(context).size.width,
              //     //   decoration: BoxDecoration(color: Colors.amber),
              //     //   child:
              //     //   VideoPlayerWidget(
              //     //     movieId: resultsList[index].id.toString()
              //     //   ),
              //     // );
              //   });
              // }).toList(),
            ),
            // SizedBox(height: 5),
            // Row(
            //   children: [
            //     SizedBox(width: MediaQuery.of(context).size.width * 0.35),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           resultsList[0].title!,
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleLarge!
            //               .copyWith(color: MyTheme.whiteColor),
            //         ),
            //         Text(
            //           resultsList[0].releaseDate!,
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleSmall!
            //               .copyWith(color: MyTheme.lightGreyColor),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 5),
            //   child: MovieItem(
            //       imagePath:
            //           'https://image.tmdb.org/t/p/w500/${resultsList[0].posterPath}'),
            // ),
          ],
        );
      },
    );
  }
}

// Container(
//   height: 200,
//   color: MyTheme.greyColor,
//   width: MediaQuery.of(context).size.width,
//   child: Center(
//       child: Text(
//     'Slider',
//     style: TextStyle(fontSize: 35),
//   )),
// ),
// YoutubePlayer(
//   controller: _controller,
//   showVideoProgressIndicator: true,
//   progressIndicatorColor: Colors.amber,
//   progressColors: const ProgressBarColors(
//     playedColor: Colors.amber,
//     handleColor: Colors.amberAccent,
//   ),
// ),
// Image.network(
//   "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
//   height: double.infinity,
//   width: double.infinity,
//   fit: BoxFit.fill,
// ),

// YoutubePlayer(
//   controller: _controller,
//   showVideoProgressIndicator: true,
//   progressIndicatorColor: Colors.amber,
//   progressColors: const ProgressBarColors(
//     playedColor: Colors.amber,
//     handleColor: Colors.amberAccent,
//   ),
//   onReady: () {
//     _controller.addListener(
//       () {},
//     );
//   },
// ),
