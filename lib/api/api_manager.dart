import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api/CreditsResponse.dart';
import 'package:movies_app/api/MovieDetailsResponse.dart';
import 'package:movies_app/api/NewReleaseResponse.dart';
import 'package:movies_app/api/SearchResponsee.dart';
import 'package:movies_app/api/VideosResponse.dart';
import 'package:movies_app/api/api_constants.dart';

class ApiManager {
  //https://api.themoviedb.org/3/movie/upcoming
  static Future<NewReleaseResponse?> getMovies() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newReleaseEndPoint,
        {'api_key': '59d33133ea6d6121632edb10332c204d'});
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return NewReleaseResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

//https://api.themoviedb.org/3/search/movie
  static Future<SearchResponsee?> getSearchResponse(
      {required String query, int? pageNumber}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.serachEndPoint, {
      'api_key': '59d33133ea6d6121632edb10332c204d',
      'query': query.toString(),
      'page': pageNumber
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return SearchResponsee.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // https://api.themoviedb.org/3/movie/{movie_id}/credits
  static Future<CreditsResponse?> getCredits({required String endPoint}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, endPoint, {
      'api_key': '59d33133ea6d6121632edb10332c204d',
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return CreditsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // https://api.themoviedb.org/3/movie/{movie_id}
  static Future<MovieDetailsResponse?> getMovieDetails(
      {required String endPoint}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, endPoint, {
      'api_key': '59d33133ea6d6121632edb10332c204d',
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return MovieDetailsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<VideosResponse?> getMovieVideo(
      {required String endPoint}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, endPoint, {
      'api_key': '59d33133ea6d6121632edb10332c204d',
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return VideosResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
