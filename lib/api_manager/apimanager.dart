
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api_manager/constants.dart';
import 'package:movies_app/responses/CategoriesResponse.dart';
import 'package:movies_app/responses/MovieTrailersResponse.dart';
import 'package:movies_app/responses/SelectedCategoryMoviesResponse.dart';

class APIManager{

  static Future<CategoriesResponse> getMoviesCategories() async{
   //String CategoriesURl='https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.APIKey}';
    Uri url = Uri.https(
       Constants.baseUrl,
       Constants.categoriesAPIService,
      {
        'api_key':Constants.APIKey
      }
    );
 try {
   var categoriesResponse= await http.get(url);
   //var categoriesResponse= await http.get(Uri.parse(CategoriesURl));
   var ResponseBody=categoriesResponse.body;
   var json=jsonDecode(ResponseBody);
   return CategoriesResponse.fromJson(json);
 } catch(e){
   throw e;
    }
  }

  static Future<SelectedCategoryMoviesResponse> getMoviesByGenreID(String GenreID,String pageNum) async{
    Uri url= Uri.https(
      Constants.baseUrl,
      Constants.categoryMoviesAPIService,
      {
        'api_key':Constants.APIKey,
        'with_genres':GenreID,
        'page': pageNum
      }
    );
    try{
      var moviesResponse=await http.get(url);
      var moviesResponseBody=moviesResponse.body;
      var json=jsonDecode(moviesResponseBody);
      var m= SelectedCategoryMoviesResponse.fromJson(json);
      print(m.results?.length);
      return m;
    }catch(e){
      throw e;
    }
  }

  Future<MovieTrailersResponse> getMovieTrailers(String MovieID) async{
    Uri url=Uri.https(
      Constants.baseUrl,
      "/3/movie/${MovieID}/videos",
      {
        'api_key':Constants.APIKey,
        'active_nav_item': 'Trailers'
      }
    );
    try{
      var response=await http.get(url);
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      return MovieTrailersResponse.fromJson(json);
    }catch(e){
      throw e;
    }




  }
}