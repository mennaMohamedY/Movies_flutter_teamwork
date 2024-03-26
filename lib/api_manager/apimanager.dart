import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api_manager/constants.dart';
import 'package:movies_app/responses/CategoriesResponse.dart';
import 'package:movies_app/responses/MovieTrailersResponse.dart';
import 'package:movies_app/responses/MoviesDetailsResponse.dart';
import 'package:movies_app/responses/PopularMoviesResponse.dart';
import 'package:movies_app/responses/ReleasesMoviesResponse.dart';
import 'package:movies_app/responses/SelectedCategoryMoviesResponse.dart';
import 'package:movies_app/responses/TopRatedMoviesResponse.dart';

class APIManager {
  static Future<CategoriesResponse> getMoviesCategories() async {
    //String CategoriesURl='https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.APIKey}';
    Uri url = Uri.https(Constants.baseUrl, Constants.categoriesAPIService,
        {'api_key': Constants.APIKey});
    try {
      var categoriesResponse = await http.get(url);
      //var categoriesResponse= await http.get(Uri.parse(CategoriesURl));
      var ResponseBody = categoriesResponse.body;
      var json = jsonDecode(ResponseBody);
      return CategoriesResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<SelectedCategoryMoviesResponse> getMoviesByGenreID(
      String GenreID, String pageNum) async {
    Uri url = Uri.https(Constants.baseUrl, Constants.categoryMoviesAPIService,
        {'api_key': Constants.APIKey, 'with_genres': GenreID, 'page': pageNum});
    try {
      var moviesResponse = await http.get(url);
      var moviesResponseBody = moviesResponse.body;
      var json = jsonDecode(moviesResponseBody);
      var m = SelectedCategoryMoviesResponse.fromJson(json);
      print(m.results?.length);
      return m;
    } catch (e) {
      throw e;
    }
  }

  static Future<MovieTrailersResponse> getMovieTrailers(String MovieID) async {
    Uri url = Uri.https(Constants.baseUrl, "/3/movie/${MovieID}/videos",
        {'api_key': Constants.APIKey, 'active_nav_item': 'Trailers'});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieTrailersResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<PopularMoviesResponse> getPopularMovies() async {
    Uri url = Uri.https(Constants.baseUrl, Constants.popularMovies,
        {'api_key': Constants.APIKey});
    try {
      var popularMoviesResponse = await http.get(url);
      var responseBody = popularMoviesResponse.body;
      var json = jsonDecode(responseBody);
      return PopularMoviesResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesDetailsResponse> getMoviesDetailsById(int movieId) async {
    Uri url = Uri.https(Constants.baseUrl, Constants.movieDetails, {
      'api_key': Constants.APIKey,
      'id': movieId,
    });
    try {
      var movieDetails = await http.get(url);
      var responseBody = movieDetails.body;
      var json = jsonDecode(responseBody);
      return MoviesDetailsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<ReleasesMoviesResponse> getReleasesMovies() async {
    Uri url = Uri.https(Constants.baseUrl, Constants.releasesMovies,
        {'api_key': Constants.APIKey});
    try {
      var releasesResponse = await http.get(url);
      var responseBody = releasesResponse.body;
      var json = jsonDecode(responseBody);
      return ReleasesMoviesResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<TopRatedMoviesResponse> getTopRatedMovies() async {
    Uri url = Uri.https(Constants.baseUrl, Constants.topRatedMovies,
        {'api_key': Constants.APIKey});
    try {
      var topRatedMoviesResponse = await http.get(url);
      var responseBody = topRatedMoviesResponse.body;
      var json = jsonDecode(responseBody);
      return TopRatedMoviesResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
