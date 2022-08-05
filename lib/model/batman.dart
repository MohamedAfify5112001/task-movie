class BatmanModel {
  List<BatmanMovieModel>? search;

  BatmanModel({this.search});

  BatmanModel.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      search = [];
      json['Search'].forEach((v) {
        search!.add(BatmanMovieModel.fromJson(v));
      });
    }
  }
}

class BatmanMovieModel {
  String? imdbID;
  String? title;
  String? year;
  String? poster;

  BatmanMovieModel({this.imdbID, this.title, this.year, this.poster});

  BatmanMovieModel.fromJson(Map<String, dynamic> json) {
    imdbID = json['imdbID'];
    title = json['Title'];
    year = json['Year'];
    poster = json['Poster'];
  }
}
