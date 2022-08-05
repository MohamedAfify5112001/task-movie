import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../widgets-shared/white_spacing.dart';
import 'category_item.dart';

class BuildListCategories extends StatelessWidget {
  const BuildListCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            BuildCategories(model: categories[index]),
        separatorBuilder: (context, index) => getWidth(20.0),
        itemCount: categories.length,
      ),
    );
  }
}
