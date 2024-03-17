import 'package:flutter/material.dart';
import 'package:movies_app/api/MovieDetailsResponse.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/api/api_manager.dart';

class GenereItem extends StatefulWidget {
  Movie movie;

  GenereItem({required this.movie});

  @override
  State<GenereItem> createState() => _GenereItemState();
}

class _GenereItemState extends State<GenereItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsResponse?>(
        future:
            ApiManager.getMovieDetails(endPoint: '/3/movie/${widget.movie.id}'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text('Network problem', style: TextStyle(color: Colors.white)),
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
          return Container();
          /*Expanded(
        child: GridView.builder(scrollDirection: Axis.horizontal,gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
             /// mainAxisSpacing: 0.2,
              ///crossAxisSpacing: 0.2
          ),
            itemBuilder:(context,index){
            return Container(
                child: Text(generes[index].name??'',style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)),
            width: MediaQuery.of(context).size.width*0.2,
              height:MediaQuery.of(context).size.width*0.2 ,);

          }
            ,itemCount:generes.length ,),
      );*/
        });
  }
}
