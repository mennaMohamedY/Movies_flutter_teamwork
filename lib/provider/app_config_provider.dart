import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/firebase/firebase_utils.dart';

class AppConfigProvider extends ChangeNotifier {
  List<Results> savedMovies = [];

  void getMoviesFromFireStore() async {
    QuerySnapshot<Results> snapshot = await FirebaseUtils.getCollection().get();
    savedMovies = snapshot.docs.map((e) => e.data()).toList();

    //savedMovies.sort((movie1, movie2) {
    //return movie1.timestamp!.compareTo(movie2.timestamp!);

    notifyListeners();
  }
}
