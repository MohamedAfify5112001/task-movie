import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';

class BackgroundPoster extends StatelessWidget {
  final PageController controller;
  final List<AllMoviesModel> allMoviesModel;

  const BackgroundPoster(
      {Key? key, required this.controller, required this.allMoviesModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildBackground(allMoviesModel[index]),
      itemCount: allMoviesModel.length,
    );
  }

  Stack _buildBackground(AllMoviesModel allMoviesModel) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            allMoviesModel.poster,
            fit: BoxFit.cover,
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
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.15, 0.65],
            colors: [
              $thirdColor.withOpacity(0.0001),
              $thirdColor.withOpacity(0.99),
            ],
          )),
        )
      ],
    );
  }
}
