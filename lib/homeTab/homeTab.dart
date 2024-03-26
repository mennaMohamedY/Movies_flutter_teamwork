import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/homeTab/recomended_movies/top_rated_movies_widget.dart';
import 'package:movies_app/homeTab/releases_movies/releases_movies_widget.dart';
import 'package:movies_app/homeTab/slider_section/popular_movies_widget.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.blackColor,
      child: ListView(
        children: [
          PopularMoviesWidget(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ReleasesMoviesWidget(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TopRatedMoviesWidget()
        ],
      ),
    );
  }
}
// CarouselSlider(
//     options: CarouselOptions(height: 200.0,autoPlay: true ),
//     items: resultsList.map((i) {
//       return Builder(
//         builder: (BuildContext context) {
//           return Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Colors.amber
//               ),
//               child:
//               Image.network(
//                   'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
//                 height: double.infinity,
//                 width: double.infinity,
//                 fit: BoxFit.fill,
//
//           ));
//         }
//       );
//     }).toList(),
// ),
