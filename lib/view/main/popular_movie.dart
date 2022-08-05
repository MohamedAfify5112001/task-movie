import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../widgets-shared/text_component.dart';
import '../../widgets-shared/white_spacing.dart';

class BuildPopularMovie extends StatelessWidget {
  final PopularMovie popularMovie;

  const BuildPopularMovie({Key? key, required this.popularMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/images/loading.gif",
            image: popularMovie.path,
            imageErrorBuilder: (context, error, stackTrace) {
              if (popularMovie.name.contains("Batman")) {
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
          getHeight(8),
          TextComponent(
            text: popularMovie.name,
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18.0),
          ),
          getHeight(5),
          RatingBar.builder(
            initialRating: popularMovie.rating.toDouble(),
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
          )
        ],
      ),
    );
  }
}
