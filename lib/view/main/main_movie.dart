import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movies_app_task/view/main/popular_movie.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../network/response/response.dart';
import '../../widgets-shared/connection.dart';
import '../../widgets-shared/text_component.dart';
import '../../widgets-shared/white_spacing.dart';
import 'all_movies.dart';
import 'build_list_category.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  ConnectivityResult? _connectivityResult;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> streamSubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      throw (e.toString());
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

  @override
  void initState() {
    super.initState();
    initConnectivity();
    streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      final PopularMovieResponse popularMovieResponse =
          PopularMovieResponseImplement();
      final AllMovieResponse allMovieResponse = AllMovieResponseImplement();
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeight(20.0),
              _getSearchField(context),
              getHeight(29.0),
              _buildCategoryOrPopular(context, text: "Category"),
              getHeight(22.0),
              const BuildListCategories(),
              getHeight(24.0),
              _buildCategoryOrPopular(context, text: "Popular"),
              getHeight(24.0),
              FutureBuilder<List<PopularMovie>>(
                future: popularMovieResponse.getPopularMovie(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 370,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => BuildPopularMovie(
                            popularMovie: snapshot.data![index]),
                        separatorBuilder: (context, index) => getWidth(20),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: $whiteColor,
                      ),
                    );
                  }
                },
              ),
              getHeight(13.0),
              _buildCategoryOrPopular(context, text: "Whole Movie"),
              getHeight(24.0),
              FutureBuilder<List<AllMoviesModel>>(
                future: allMovieResponse.getAllMovie(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: (150.0 / 290.0),
                      children: List.generate(
                          snapshot.data!.length,
                          (index) => BuildAllMovies(
                                allMoviesModel: snapshot.data![index],
                              )),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: $whiteColor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return buildNoConnection(context);
    }
  }

  Row _buildCategoryOrPopular(BuildContext context, {required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextComponent(
          text: text,
          textStyle: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: 18.0),
        ),
        TextComponent(
          text: "see more",
          textStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: 13.0, color: $greyColor),
        ),
      ],
    );
  }

  Widget _getSearchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadiusDirectional.all(Radius.circular(40.0)),
          border: Border.all(color: $greyColor)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.search, size: 22, color: $greyColor),
            getWidth(5.0),
            TextComponent(
              text: "Search Your Movie",
              textStyle: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: $greyColor),
            )
          ],
        ),
      ),
    );
  }
}
