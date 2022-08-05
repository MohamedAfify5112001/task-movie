import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../widgets-shared/text_component.dart';
import '../../widgets-shared/white_spacing.dart';

class BuildCardMovie extends StatelessWidget {
  final AllMoviesModel allMoviesModel;

  const BuildCardMovie({Key? key, required this.allMoviesModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: $primaryColor.withOpacity(.7),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(30.0),
            topEnd: Radius.circular(30.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
                child: _buildPoster(
                    allMoviesModel.poster, context, allMoviesModel.title)),
            TextComponent(
                text: allMoviesModel.title,
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20.0, overflow: TextOverflow.visible)),
            getHeight(5.0),
            RatingBar.builder(
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(String path, BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Image.network(
          path,
          errorBuilder: (context, _, error) {
            if (title.contains("Batman")) {
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
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
