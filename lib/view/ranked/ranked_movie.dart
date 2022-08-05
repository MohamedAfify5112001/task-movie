import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../network/response/response.dart';
import '../../widgets-shared/connection.dart';
import 'background_movie_poster.dart';
import 'card_movie.dart';

class RankedMovie extends StatefulWidget {
  const RankedMovie({Key? key}) : super(key: key);

  @override
  State<RankedMovie> createState() => _RankedMovieState();
}

class _RankedMovieState extends State<RankedMovie> {
  final PageController controller = PageController(initialPage: 0);
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
      final AllMovieRankedResponse allMovieRankedResponse =
          AllMovieRankedResponseImplement();
      return FutureBuilder<List<AllMoviesModel>>(
        future: allMovieRankedResponse.getAllMovieRanked(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                BackgroundPoster(
                  controller: controller,
                  allMoviesModel: snapshot.data!,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: CarouselSlider(
                      items: List.generate(
                          snapshot.data!.length,
                          (index) => BuildCardMovie(
                              allMoviesModel: snapshot.data![index])),
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: .75,
                          height: MediaQuery.of(context).size.height * .7,
                          enlargeCenterPage: true,
                          onPageChanged: (index, _) {
                            return WidgetsBinding.instance
                                .addPostFrameCallback((_) {
                              if (controller.hasClients) {
                                controller.animateToPage(index,
                                    duration: const Duration(milliseconds: 1),
                                    curve: Curves.ease);
                              }
                            });
                          }),
                    )),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: $whiteColor,
              ),
            );
          }
        },
      );
    } else {
      return buildNoConnection(context);
    }
  }
}
