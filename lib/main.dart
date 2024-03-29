import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/firebase/firebase_options.dart';
import 'package:movies_app/home_screen.dart';
import 'package:movies_app/provider/app_config_provider.dart';
import 'package:movies_app/searchTab/SearchItemDetailsVideo.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// await FirebaseFirestore.instance.disableNetwork();
  await FirebaseFirestore.instance.enableNetwork();
  // The default value is 40 MB. The threshold must be set to at least 1 MB,
// and can be set to Settings.CACHE_SIZE_UNLIMITED to disable garbage collection.

  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

//AIzaSyDFD2qo0QUol_6B3EF9P93G_oQmPuIVe74
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchItemDetailsVideo.routeName: (context) => SearchItemDetailsVideo()
      },
      debugShowCheckedModeBanner: false,
      theme: MyTheme.darkTheme,
    );
  }
}
