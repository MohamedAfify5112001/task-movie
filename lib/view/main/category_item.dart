import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../model/movie_model.dart';
import '../../widgets-shared/text_component.dart';

class BuildCategories extends StatelessWidget {
  final CategoryModel model;

  const BuildCategories({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 750,
      decoration: BoxDecoration(
        color: $ForthColor.withOpacity(0.6),
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(model.path),
            ),
            TextComponent(
                text: model.name,
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: $greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
