import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/api/SearchResponsee.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/searchTab/SearchItem.dart';
import 'package:movies_app/searchTab/SearchItemDetailsVideo.dart';

///import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
  int pageNumber = 1;
}

class _SearchTabState extends State<SearchTab> {
  String? query;
  List<Movie> movies = [];

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
              padding: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff424141)),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 17),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 17)),
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
                          Navigator.of(context).pushNamed(
                              SearchItemDetailsVideo.routeName,
                              arguments: movies[index]);
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
