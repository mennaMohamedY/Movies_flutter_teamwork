import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/provider/app_config_provider.dart';
import 'package:movies_app/watchListTab/movie_item.dart';
import 'package:provider/provider.dart';

class WatchListTab extends StatefulWidget {
  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    if (provider.savedMovies.isEmpty) {
      provider.getMoviesFromFireStore();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 70),
        Text(
          'Watch List',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(thickness: 2, color: MyTheme.sectionsGrey),
            itemBuilder: (context, index) => MovieItem(
                movie: provider.savedMovies[index],
                url: provider.savedMovies[index].posterPath,
                backDrop: provider.savedMovies[index].backdropPath),
            itemCount: provider.savedMovies.length,
          ),
        )
        /* FutureBuilder<NewReleaseResponse?>(
            future: ApiManager.getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
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
              var movies = snapshot.data?.results ?? [];
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 2, color: MyTheme.sectionsGrey),
                    itemBuilder: (context, index) => MovieItem(
                        movie: movies[index],
                        url: movies[index].posterPath,
                        backDrop: movies[index].backdropPath),
                    itemCount: movies.length),
              );
            })*/
      ],
    );
  }
}
