import 'package:cloud_firestore/cloud_firestore.dart';

import '../responses/ReleasesMoviesResponse.dart';

class FirebaseUtils {
  static const String collectionName = 'SavedMovies';

  static CollectionReference<Results> getCollection() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<Results>(
            fromFirestore: (snapshot, options) =>
                Results.fromJson(snapshot.data()!),
            toFirestore: (movie, options) => movie.toJson());
  }

  static Future<void> setMovieToFirestore(Results movie) {
    CollectionReference<Results> collection = getCollection();
    return collection.doc(movie.id.toString()).set(movie);
  }
}
