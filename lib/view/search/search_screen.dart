import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../network/response/response.dart';
import '../../widgets-shared/connection.dart';
import '../../widgets-shared/text_component.dart';
import '../../widgets-shared/white_spacing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final AllMovieResponse allMovieResponse = AllMovieResponseImplement();
  List<AllMoviesModel> getMovies = [];
  List<AllMoviesModel> $Movies = [];
  ConnectivityResult? _connectivityResult;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> streamSubscription;

  _initConnection() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      throw (e.message ?? "");
    }
    if (!mounted) {
      Future.value(null);
    }
    return _updateConnectivityStatus(connectivityResult);
  }

  _updateConnectivityStatus(ConnectivityResult connectivityResult) async {
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }

  _bind() async {
    getMovies = await allMovieResponse.getAllMovie();
  }

  _init() {
    setState(() {
      $Movies = getMovies;
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    _searchController.clear();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    _init();
    super.initState();
    _initConnection();
    streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: _searchItem,
                style: Theme.of(context).textTheme.displaySmall,
                cursorColor: $greyColor,
                controller: _searchController,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(14.0),
                  hintText: "Search Movie",
                ),
              ),
              getHeight(20.0),
              GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: (150.0 / 290.0),
                  children: List.generate(
                      $Movies.isEmpty ? getMovies.length : $Movies.length,
                      (index) => $Movies.isEmpty
                          ? _buildItem(getMovies[index])
                          : _buildItem($Movies[index])))
            ],
          ),
        ),
      );
    } else {
      return buildNoConnection(context);
    }
  }

  _buildItem(AllMoviesModel allMoviesModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          allMoviesModel.poster,
          errorBuilder: (context, _, error) {
            if (allMoviesModel.title.contains("Batman")) {
              return const Image(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                      "https://i.pinimg.com/564x/10/b6/09/10b6098e35b07f9beece4b3d77509561.jpg"));
            } else {
              return const Image(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                      "https://i.pinimg.com/564x/f0/eb/d6/f0ebd6d772eaa8221f7b9ab82f4e41a5.jpg"));
            }
          },
        ),
        getHeight(10.0),
        TextComponent(
            text: allMoviesModel.title,
            textStyle: Theme.of(context).textTheme.displayMedium!)
      ],
    );
  }

  _searchItem(String value) {
    final List<AllMoviesModel> searchingMovie = getMovies.where((movie) {
      final String titleMovie = movie.title.toLowerCase();
      final input = value.toLowerCase();
      return titleMovie.contains(input);
    }).toList();
    setState(() => $Movies = searchingMovie);
  }
}
