class CategoryModel {
  String path;
  String name;

  CategoryModel({required this.path, required this.name});
}

class PopularMovie {
  double rating;
  String path;
  String name;

  PopularMovie({required this.rating, required this.path, required this.name});
}

class AllMoviesModel {
  double rating;

  String imdbID;
  String title;
  String year;
  String poster;

  AllMoviesModel({required this.rating, required this.imdbID,
    required this.title,
    required this.year,
    required this.poster});
}
