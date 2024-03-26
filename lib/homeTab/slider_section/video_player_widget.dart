// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class VideoPlayerWidget extends StatelessWidget {
//   YoutubePlayerController _controller = YoutubePlayerController(
//     initialVideoId: 'iLnmTe5Q2Qw',
//     flags: YoutubePlayerFlags(
//       autoPlay: true,
//       mute: true
//     )
//   );
//   @override
//   Widget build(BuildContext context) {
//
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//       progressIndicatorColor: Colors.amber,
//       progressColors: const ProgressBarColors(
//         playedColor: Colors.amber,
//         handleColor: Colors.amberAccent,
//       ),
//       onReady: () {
//         _controller.addListener(
//           () {
//             return;
//           },
//         );
//       },
//     ),
//   }
// }

////////////////////////////////////////////////////////
// YoutubePlayer(
//   controller: _controller,
//   showVideoProgressIndicator: true,
//   progressIndicatorColor: Colors.amber,
//   progressColors: const ProgressBarColors(
//     playedColor: Colors.amber,
//     handleColor: Colors.amberAccent,
//   ),
// ),
// CarouselSlider(
//     items: [1, 2, 3, 4, 5].map((i) {
//       return Builder(
//         builder: (BuildContext context) {
//           return Container(
//               width: MediaQuery.of(context).size.width,
//               margin:
//                   EdgeInsets.symmetric(horizontal: 5.0),
//               decoration:
//                   BoxDecoration(color: Colors.amber),
//               child: Text(
//                 'text $i',
//                 style: TextStyle(fontSize: 16.0),
//               ));
//         },
//       );
//     }).toList(),
//     options: CarouselOptions(
//       height: 200,
//       aspectRatio: 16 / 9,
//       viewportFraction: 0.8,
//       initialPage: 0,
//       enableInfiniteScroll: true,
//       reverse: false,
//       autoPlay: true,
//       autoPlayInterval: Duration(seconds: 3),
//       autoPlayAnimationDuration:
//           Duration(milliseconds: 800),
//       autoPlayCurve: Curves.fastOutSlowIn,
//       enlargeCenterPage: true,
//       enlargeFactor: 0.3,
//       scrollDirection: Axis.horizontal,
//     )),
