import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../widgets-shared/text_component.dart';
import '../../widgets-shared/white_spacing.dart';

class BuildAllMovies extends StatelessWidget {
  final AllMoviesModel allMoviesModel;

  const BuildAllMovies({
    required this.allMoviesModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: allMoviesModel.poster,
              imageErrorBuilder: (context, error, stackTrace) {
                if (allMoviesModel.title.contains("Batman")) {
                  return const Image(
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/2f/bc/cc/2fbccc49210e500974826cd4995ec193.jpg"));
                } else {
                  return const Image(
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/f0/eb/d6/f0ebd6d772eaa8221f7b9ab82f4e41a5.jpg"));
                }
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: $secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 3.0),
                  child: TextComponent(
                    text: allMoviesModel.year,
                    textStyle: Theme.of(context).textTheme.displaySmall!,
                  ),
                ),
              ),
            )
          ],
        ),
        getHeight(8),
        TextComponent(
          text: allMoviesModel.title,
          textStyle: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: 18.0),
        ),
        getHeight(5),
        SizedBox(
          child: RatingBar.builder(
            initialRating: allMoviesModel.rating,
            unratedColor: $greyColor,
            itemSize: 20,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.only(right: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              size: 1,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        )
      ],
    );
  }
}
