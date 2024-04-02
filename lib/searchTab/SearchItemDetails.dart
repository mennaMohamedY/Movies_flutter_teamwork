import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/MovieDetailsResponse.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/firebase/firebase_utils.dart';
import 'package:movies_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';

class SearchItemDetails extends StatefulWidget {
  Results movie;

  SearchItemDetails({required this.movie});

  @override
  State<SearchItemDetails> createState() => _SearchItemDetailsState();
}

class _SearchItemDetailsState extends State<SearchItemDetails> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Row(
      children: [
        Stack(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Image.network(
                    height: 200,
                    width: 110,
                    fit: BoxFit.cover,
                    'https://image.tmdb.org/t/p/w92${widget.movie.posterPath}')),
            InkWell(
              child: isClicked == false
                  ? Image.asset('assets/images/bookmark (1).png')
                  : Image.asset('assets/images/bookmark.png'),
              onTap: () {
                isClicked = true;

                widget.movie.timestamp = Timestamp.now();
                FirebaseUtils.setMovieToFirestore(widget.movie)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  provider.getMoviesFromFireStore();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('saved successfully'),
                    duration: Duration(seconds: 2),
                  ));
                }).onError((error, stackTrace) => null);
                setState(() {});
              },
            )
          ],
        ),
        FutureBuilder<MovieDetailsResponse?>(
            future: ApiManager.getMovieDetails(
                endPoint: '/3/movie/${widget.movie.id}'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Text('Network problem',
                        style: TextStyle(color: Colors.white)),
                    ElevatedButton(
                        onPressed: () {
                          ApiManager.getMovies();
                          setState(() {});
                        },
                        child: Text('Try Again',
                            style: TextStyle(color: Colors.white)))
                  ],
                );
              }
              if (snapshot.data?.success == false) {
                return Column(
                  children: [
                    Text(snapshot.data!.status_message ?? '',
                        style: TextStyle(color: Colors.white)),
                    ElevatedButton(
                        onPressed: () {
                          ApiManager.getMovies();
                          setState(() {});
                        },
                        child: Text('Try Again'))
                  ],
                );
              }
              var generes = snapshot.data?.genres ?? [];
              double popularity = snapshot.data?.popularity ?? 0;
              String overview = snapshot.data?.overview ?? '';
              print(generes.length);
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.height * 0.02,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.width * 0.05,
                            childAspectRatio: 5 / 5),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white)),
                          height: MediaQuery.of(context).size.width * 0.10,
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: Text(
                            generes[index].name ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        itemCount: generes.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movie.overview ?? '',
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/star-2.png'),
                        SizedBox(width: 3),
                        Text(
                          '${widget.movie.popularity}',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.start,
                        )
                      ],
                    )
                  ],
                ),
              );
            })

        ///GenereItem(movie: movie,)
      ],
    );
  }
}
