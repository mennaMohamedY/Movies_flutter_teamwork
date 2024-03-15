
import 'package:flutter/material.dart';
import 'package:movies_app/BrowseTab/searchbarr.dart';
import 'package:movies_app/BrowseTab/singlecategorydesign.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/api_manager/apimanager.dart';
import 'package:movies_app/responses/CategoriesResponse.dart';


class CategoriesScreen extends StatefulWidget {
  static String routeName="CategoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var searchResult=[];
  List<Genres>? categoriesList=[];
  bool notFound=false;

  final TextEditingController searchcontroller=TextEditingController();


  //for Search part

  void onQueryChanged(String query) {
    setState(() {
      searchResult = categoriesList!
          .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if(query.isNotEmpty && searchResult.isEmpty){
        notFound=true;
        print("searchlist length..... ${searchResult.length}");

      }
      if(query.isEmpty){
        notFound=false;
      }
      if(searchResult.length==0){
        searchResult=[];
      }
      print("searchlist length..... ${searchResult.length}");

      print("not found value......${notFound}");
      print("searchlist length..... ${searchResult.isEmpty}");

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
//        color: Colors.black,
        padding: EdgeInsets.only(top: 12,),
        child: Column(
          children: [
          SearchBarr(OnQueryChanged: onQueryChanged),
         FutureBuilder(
             future: APIManager.getMoviesCategories(),
             builder:(context,snapshot){
               if(snapshot.connectionState ==ConnectionState.waiting){
                 return CircularProgressIndicator(color: MyTheme.sectionsGrey,);
               }
               if(snapshot.hasError){
                 //error from my side
                 return Column(children: [Text("Error Occured ${snapshot.error}",style: TextStyle(color: Colors.white,)),
                 ElevatedButton(onPressed: (){}, child: Text("Try Again!"))],);
               }
               if(snapshot.data?.success == false){
                 return Column(children: [Text("Error message: ${snapshot.data?.status_message} \n with error Code ${snapshot.data?.status_code}",style: TextStyle(color: Colors.white,),),
                   ElevatedButton(onPressed: (){}, child: Text("Try Again!"))],);
               }
               categoriesList=snapshot.data!.genres;
               return  Expanded(
                 child: Padding(padding: EdgeInsets.symmetric(horizontal: 7),
                   child: GridView.builder(
                     itemBuilder: (context,index){
                       return (notFound)?
                       Center(child: Column(children: [Icon(Icons.error_outline),Text("NotFound",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)],),)
                           :SingleCategoryDesign(category: (searchResult.isEmpty)?categoriesList![index]:searchResult[index]);
                     },
                     itemCount: (searchResult.isEmpty)?
                     categoriesList?.length: (notFound)? 1:searchResult.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 12,crossAxisSpacing: 12,),
                   ),
                 ),
               );
             })
        ],),
      ),
    );
  }

}
