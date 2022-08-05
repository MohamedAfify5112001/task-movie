
import 'package:movies_app_task/model/batman.dart';

import '../../model/movie_model.dart';
import '../../model/star_war.dart';
import '../services/services.dart';

abstract class Repository {
  Future<BatmanModel> getBatmanModel();

  Future<StarWarsModel> getStarWarModel();
}

class RepositoryImplement implements Repository {
  RepositoryImplement._internalInstance();

  static get instance => RepositoryImplement._internalInstance();

  factory RepositoryImplement() => instance;

  @override
  Future<BatmanModel> getBatmanModel() async {
    NetworkServices networkServices = NetworkServicesImplement();
    BatmanModel batmanModel = await networkServices.getBatman();
    return batmanModel;
  }

  @override
  Future<StarWarsModel> getStarWarModel() async {
    NetworkServices networkServices = NetworkServicesImplement();
    StarWarsModel starWarsModel = await networkServices.getStarWars();
    return starWarsModel;
  }
}

abstract class PopularMovieResponse {
  Future<List<PopularMovie>> getPopularMovie();
}

class PopularMovieResponseImplement implements PopularMovieResponse {
  @override
  Future<List<PopularMovie>> getPopularMovie() async {
    Repository responseData = RepositoryImplement();
    List<PopularMovie> popular = [];
    BatmanModel batmanModel = await responseData.getBatmanModel();
    StarWarsModel starWarsModel = await responseData.getStarWarModel();
    for (int i = 0; i < 8; i++) {
      popular.add(PopularMovie(
          rating: 4.5,
          path: batmanModel.search![i].poster ??
              "https://i.pinimg.com/564x/10/b6/09/10b6098e35b07f9beece4b3d77509561.jpg",
          name: batmanModel.search![i].title ?? ""));
      popular.add(PopularMovie(
          rating: 4.5,
          path: starWarsModel.search![i].poster ??
              "https://i.pinimg.com/564x/f0/eb/d6/f0ebd6d772eaa8221f7b9ab82f4e41a5.jpg",
          name: starWarsModel.search![i].title ?? ""));
    }
    popular.shuffle();
    return popular;
  }
}

abstract class AllMovieResponse {
  Future<List<AllMoviesModel>> getAllMovie();
}

class AllMovieResponseImplement implements AllMovieResponse {
  @override
  Future<List<AllMoviesModel>> getAllMovie() async {
    Repository responseData = RepositoryImplement();
    BatmanModel batmanModel = await responseData.getBatmanModel();
    StarWarsModel starWarsModel = await responseData.getStarWarModel();
    List<StarWarsMovieModel> starWarsModelList = starWarsModel.search!;
    List<BatmanMovieModel> batmanModelList = batmanModel.search!;
    List<AllMoviesModel> $Movies = [];
    for (var batman in batmanModelList) {
      $Movies.add(AllMoviesModel(
          rating: 4.5,
          imdbID: batman.imdbID ?? "",
          title: batman.title ?? "",
          year: batman.year ?? "",
          poster: batman.poster ?? ""));
    }
    for (var starWar in starWarsModelList) {
      $Movies.add(AllMoviesModel(
          rating: 4,
          imdbID: starWar.imdbID ?? "",
          title: starWar.title ?? "",
          year: starWar.year ?? "",
          poster: starWar.poster ?? ""));
    }
    $Movies.shuffle();
    return $Movies;
  }
}

abstract class AllMovieRankedResponse {
  Future<List<AllMoviesModel>> getAllMovieRanked();
}

class AllMovieRankedResponseImplement implements AllMovieRankedResponse {
  @override
  Future<List<AllMoviesModel>> getAllMovieRanked() async {
    Repository responseData = RepositoryImplement();
    BatmanModel batmanModel = await responseData.getBatmanModel();
    StarWarsModel starWarsModel = await responseData.getStarWarModel();
    List<StarWarsMovieModel> starWarsModelList = starWarsModel.search!;
    List<BatmanMovieModel> batmanModelList = batmanModel.search!;
    List<AllMoviesModel> $Movies = [];
    for (int i = 0; i < 4; i++) {
      $Movies.add(AllMoviesModel(
          rating: 5,
          imdbID: starWarsModelList[i].imdbID ?? "",
          title: starWarsModelList[i].title ?? "",
          year: starWarsModelList[i].year ?? "",
          poster: starWarsModelList[i].poster ?? ""));
    }
    for (int i = 0; i < 6; i++) {
      $Movies.add(AllMoviesModel(
          rating: 5,
          imdbID: batmanModelList[i].imdbID ?? "",
          title: batmanModelList[i].title ?? "",
          year: batmanModelList[i].year ?? "",
          poster: batmanModelList[i].poster ?? ""));
    }
    $Movies.shuffle();
    return $Movies;
  }
}
