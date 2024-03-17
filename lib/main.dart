import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/firebase/firebase_options.dart';
import 'package:movies_app/home_screen.dart';
import 'package:movies_app/searchTab/SearchItemDeatils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(

      /// ChangeNotifierProvider(create:(context)=>AppConfigProvider()
      MyApp());
}

//AIzaSyDFD2qo0QUol_6B3EF9P93G_oQmPuIVe74
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchItemDetails.routeName: (context) => SearchItemDetails()
      },
      debugShowCheckedModeBanner: false,
      theme: MyTheme.darkTheme,
    );
  }
}
