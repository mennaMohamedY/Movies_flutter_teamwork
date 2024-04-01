import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/firebase/firebase_options.dart';
import 'package:movies_app/home_screen.dart';
import 'package:movies_app/provider/app_config_provider.dart';
import 'package:movies_app/searchTab/SearchItemDetailsVideo.dart';
import 'package:provider/provider.dart';

import 'BrowseTab/selectedcategorymovies/selectedcategorymovies.dart';
import 'homeTab/movies_details/movies_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchItemDetailsVideo.routeName: (context) => SearchItemDetailsVideo(),
        SelectedCategoryMoviesScreen.routeName: (context) =>
            SelectedCategoryMoviesScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
    );
  }
}
