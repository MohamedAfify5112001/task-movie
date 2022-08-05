class StarWarsModel {
  List<StarWarsMovieModel>? search;

  StarWarsModel({this.search});

  StarWarsModel.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      search = [];
      json['Search'].forEach((v) {
        search!.add(StarWarsMovieModel.fromJson(v));
      });
    }
  }
}

class StarWarsMovieModel {
  String? imdbID;
  String? title;
  String? year;
  String? poster;

  StarWarsMovieModel({this.imdbID, this.title, this.year, this.poster});

  StarWarsMovieModel.fromJson(Map<String, dynamic> json) {
    imdbID = json['imdbID'];
    title = json['Title'];
    year = json['Year'];
    poster = json['Poster'];
  }
}
