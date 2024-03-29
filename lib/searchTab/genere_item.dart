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
          double popularity = snapshot.data?.popularity ?? 0;
          String overview = snapshot.data?.overview ?? '';
          print(generes.length);
          return Column(children: [
            Container(
              child: Text(
                'movie',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                'movie',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                'movie',
                style: TextStyle(color: Colors.white),
              ),
            )
            /* Expanded(
            child: Column(children: [

                 SizedBox(height:2,
                   child: GridView.builder(gridDelegate:
                   SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount:3 ,
                     crossAxisSpacing:MediaQuery.of(context).size.height*0.02 ,
                     mainAxisSpacing:MediaQuery.of(context).size.width*0.01 ,
                     childAspectRatio: 5/3
                   ),
                    itemBuilder:(context,index)=>Container(color:Colors.white,
                      height:MediaQuery.of(context).size.width*0.2 ,
                      width: MediaQuery.of(context).size.width*0.2,
                      child:Text(generes[index].name??'',style: TextStyle(color:Colors.white),) ,
                    ),itemCount: generes.length,),
                 ),


            ],),
          )*/
          ]);
        });
  }
}
