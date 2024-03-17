/// images : {"base_url":"http://image.tmdb.org/t/p/","secure_base_url":"https://image.tmdb.org/t/p/","backdrop_sizes":["w300","w780","w1280","original"],"logo_sizes":["w45","w92","w154","w185","w300","w500","original"],"poster_sizes":["w92","w154","w185","w342","w500","w780","original"],"profile_sizes":["w45","w185","h632","original"],"still_sizes":["w92","w185","w300","original"]}
/// change_keys : ["adult","air_date","also_known_as","alternative_titles","biography","birthday","budget","cast","certifications","character_names","created_by","crew","deathday","episode","episode_number","episode_run_time","freebase_id","freebase_mid","general","genres","guest_stars","homepage","images","imdb_id","languages","name","network","origin_country","original_name","original_title","overview","parts","place_of_birth","plot_keywords","production_code","production_companies","production_countries","releases","revenue","runtime","season","season_number","season_regular","spoken_languages","status","tagline","title","translations","tvdb_id","tvrage_id","type","video","videos"]

class ImageResponse {
  ImageResponse({
    this.images,
    this.changeKeys,
  });

  ImageResponse.fromJson(dynamic json) {
    images = json['images'] != null ? Image.fromJson(json['images']) : null;
    changeKeys =
        json['change_keys'] != null ? json['change_keys'].cast<String>() : [];
  }

  Image? images;
  List<String>? changeKeys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.toJson();
    }
    map['change_keys'] = changeKeys;
    return map;
  }
}

/// base_url : "http://image.tmdb.org/t/p/"
/// secure_base_url : "https://image.tmdb.org/t/p/"
/// backdrop_sizes : ["w300","w780","w1280","original"]
/// logo_sizes : ["w45","w92","w154","w185","w300","w500","original"]
/// poster_sizes : ["w92","w154","w185","w342","w500","w780","original"]
/// profile_sizes : ["w45","w185","h632","original"]
/// still_sizes : ["w92","w185","w300","original"]

class Image {
  Image({
    this.baseUrl,
    this.secureBaseUrl,
    this.backdropSizes,
    this.logoSizes,
    this.posterSizes,
    this.profileSizes,
    this.stillSizes,
  });

  Image.fromJson(dynamic json) {
    baseUrl = json['base_url'];
    secureBaseUrl = json['secure_base_url'];
    backdropSizes = json['backdrop_sizes'] != null
        ? json['backdrop_sizes'].cast<String>()
        : [];
    logoSizes =
        json['logo_sizes'] != null ? json['logo_sizes'].cast<String>() : [];
    posterSizes =
        json['poster_sizes'] != null ? json['poster_sizes'].cast<String>() : [];
    profileSizes = json['profile_sizes'] != null
        ? json['profile_sizes'].cast<String>()
        : [];
    stillSizes =
        json['still_sizes'] != null ? json['still_sizes'].cast<String>() : [];
  }

  String? baseUrl;
  String? secureBaseUrl;
  List<String>? backdropSizes;
  List<String>? logoSizes;
  List<String>? posterSizes;
  List<String>? profileSizes;
  List<String>? stillSizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base_url'] = baseUrl;
    map['secure_base_url'] = secureBaseUrl;
    map['backdrop_sizes'] = backdropSizes;
    map['logo_sizes'] = logoSizes;
    map['poster_sizes'] = posterSizes;
    map['profile_sizes'] = profileSizes;
    map['still_sizes'] = stillSizes;
    return map;
  }
}
