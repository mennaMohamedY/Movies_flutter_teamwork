import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';

class FirebaseUtils {
  static const String collectionName = 'SavedMovies';

  static CollectionReference<Movie> getCollection() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<Movie>(
            fromFirestore: (snapshot, options) =>
                Movie.fromJson(snapshot.data()!),
            toFirestore: (movie, options) => movie.toJson());
  }

  static Future<void> setMovieToFirestore(Movie movie) {
    CollectionReference<Movie> collection = getCollection();
    return collection.doc(movie.id.toString()).set(movie);
  }
}
