import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api/SearchResponsee.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/searchTab/SearchItem.dart';

import '../homeTab/movies_details/movies_details_screen.dart';
import '../responses/ReleasesMoviesResponse.dart';

///import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
  int pageNumber = 1;
}

class _SearchTabState extends State<SearchTab> {
  String? query;
  List<Results> movies = [];

  ///ScrollController _controller=ScrollController();

  /* void initState() {
  _controller.addListener(() {
loadPges();
   });
    super.initState();
  }*/

  /* void loadPges(){
    if(_controller.position.pixels==_controller.position.maxScrollExtent){
      setState(() {
        ApiManager.getSearchResponse(query:query??'',pageNumber: widget.pageNumber);
        widget.pageNumber++;
      });
    }}*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff424141)),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
                onChanged: (text) {
                  query = text;

                  /// check(query!);
                  setState(() {});
                },
              ),
            )),
        body: query == null
            ? Center(child: Image.asset('assets/images/Group 22.png'))
            : FutureBuilder<SearchResponsee?>(
                future: ApiManager.getSearchResponse(query: query!),
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
                              ApiManager.getSearchResponse(query: query!);
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
                              ApiManager.getSearchResponse(query: query!);
                              setState(() {});
                            },
                            child: Text('Try Again'))
                      ],
                    );
                  }
                  movies = snapshot.data?.results ?? [];
                  if (movies.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(thickness: 2, color: MyTheme.sectionsGrey),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //     SearchItemDetailsVideo.routeName,
                          //     arguments: movies[index]);
                          Navigator.pushNamed(
                              context, MovieDetailsScreen.routeName,
                              arguments: movies[index].id.toString());
                        },
                        child: SearchItem(
                            movie: movies[index],
                            url: movies[index].posterPath,
                            backDrop: movies[index].backdropPath),
                      ),
                      /* Text(movies[index].title ?? '',
                        style: TextStyle(color: Colors.white),),*/
                      itemCount: movies.length,
                    );
                  }
                  return Center(
                      child: Image.asset('assets/images/Group 22.png'));
                }));
  }

/* void check(String query){
    if(query.isNotEmpty){
      provider.filterList(query);
      movies=provider.filtered;
      setState(() {

      });
    }
  }*/
}
