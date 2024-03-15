

import 'package:flutter/material.dart';
import 'package:movies_app/BrowseTab/searchbarr.dart';
import 'package:movies_app/BrowseTab/selectedcategorymovies/singlemoviedesign.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/responses/CategoriesResponse.dart';
import 'package:movies_app/responses/SelectedCategoryMoviesResponse.dart';


class SelectedCategoryMoviesScreen extends StatefulWidget {
  static String routeName="SelectedCategoryMoviesScreen";

  @override
  State<SelectedCategoryMoviesScreen> createState() => _SelectedCategoryMoviesScreenState();
}

class _SelectedCategoryMoviesScreenState extends State<SelectedCategoryMoviesScreen> {
  List<Results> moviesList = [];
  List<Results> searchResult = [];
  bool notFound = false;
  var futureBuilderFlag = 0;
  ScrollController _scrollController = ScrollController();
  late Genres categoryGenere;
  int pageNum = 1;


  ///for search part
  void onQueryChanged(String query) {
    setState(() {
      searchResult = moviesList
      !.where((item) => item.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (query.isNotEmpty && searchResult!.isEmpty) {
        notFound = true;
        print("searchlist length..... ${searchResult?.length}");
      }
      if (query.isEmpty) {
        notFound = false;
      }
      if (searchResult?.length == 0) {
        searchResult = [];
      }
    });
  }

  ///pagination part
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        fetch();
      }
    });
  }

  ///for pagination part
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  ///for pagination part
  void fetch() async {
    futureBuilderFlag = 1;
    pageNum += 1;
    var response = await APIManager.getMoviesByGenreID(
        '${categoryGenere.id}', '${pageNum}');
    var newList = response.results;

    setState(() {
      moviesList.addAll(newList!.map((movie) {
        return movie;
      }).toList());
    });
  }


  @override
  Widget build(BuildContext context) {
    categoryGenere = ModalRoute
        .of(context)
        ?.settings
        .arguments as Genres;

    print("categoryID: ...... ${categoryGenere.id}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("MoviesApp"),),
      body: Container(
        padding: EdgeInsets.only(top: 12,),
        child: Column(
          children: [
            SearchBarr(OnQueryChanged: onQueryChanged),
            (futureBuilderFlag != 0) ? Expanded(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 7),
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index <moviesList.length){
                      return (notFound)?
                      Center(child: Column(children: [Icon(Icons.error_outline),Text("NotFound",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)],),)
                          :
                      SingleMovieDesign(movie: (searchResult.isEmpty)?moviesList![index]:searchResult[index]);
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                  itemCount: (searchResult.isEmpty)
                      ? moviesList!.length+1
                      : (notFound) ? 1 : searchResult.length
                  ,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 3 / 4),
                ),
              ),
            ) : FutureBuilder(
                future: APIManager.getMoviesByGenreID(
                    '${categoryGenere.id}', '${pageNum}'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: MyTheme.sectionsGrey,);
                  }
                  if (snapshot.hasError) {
                    print(snapshot.data?.results?.length);
                    //error from my side
                    return Column(children: [
                      Text("Error Occured ${snapshot.error}",
                          style: TextStyle(color: Colors.white,)),
                      ElevatedButton(onPressed: () {
                        APIManager.getMoviesByGenreID(
                            '${categoryGenere.id}', '${pageNum}');
                      }, child: Text("Try Again!"))
                    ],);
                  }
                  if (snapshot.data?.success == false) {
                    return Column(children: [
                      Text("Error message: ${snapshot.data
                          ?.status_message} \n with error Code ${snapshot.data
                          ?.status_code}",
                        style: TextStyle(color: Colors.white,),),
                      ElevatedButton(onPressed: () {
                        APIManager.getMoviesByGenreID(
                            '${categoryGenere.id}', '${pageNum}');
                      }, child: Text("Try Again!"))
                    ],);
                  }
                  moviesList = snapshot.data!.results!;
                  print('listLength......${moviesList.length}');
                  return Expanded(
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 7),
                      child: GridView.builder(
                        controller: _scrollController,

                        itemBuilder: (context, index) {
                          return (notFound) ?
                          Center(child: Column(children: [
                            Icon(Icons.error_outline),
                            Text("NotFound", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),)
                          ],),)
                              : //moviesList[index];
                          SingleMovieDesign(movie: (searchResult.isEmpty)
                              ? moviesList![index]
                              : searchResult[index]);
                        },
                        itemCount: (searchResult.isEmpty)
                            ? moviesList?.length
                            : (notFound) ? 1 : searchResult.length
                        ,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3 / 4),
                      ),
                    ),
                  );
                })
          ],),
      ),
    );
  }
}
