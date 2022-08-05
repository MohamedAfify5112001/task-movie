import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildNoConnection(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      height: 300,
      child: Lottie.asset("assets/json/no internet.json"),
    ),
  );
}
