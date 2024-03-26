import 'package:flutter/material.dart';
import 'package:movies_app/BrowseTab/selectedcategorymovies/selectedcategorymovies.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/homeTab/movies_details/movies_details_screen.dart';
import 'package:movies_app/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        SelectedCategoryMoviesScreen.routeName: (context) =>
            SelectedCategoryMoviesScreen(),
      },
      debugShowCheckedModeBanner: false,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
