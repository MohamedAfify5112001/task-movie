import 'package:flutter/material.dart';
import 'package:movies_app_task/view/home/home_screen.dart';

import 'constant/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        scaffoldBackgroundColor: $primaryColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: $primaryColor,
            elevation: 1.5,
            shadowColor: $primaryColor),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            fontSize: 26.0,
            color: $whiteColor,
          ),
          displayMedium: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: $whiteColor,
          ),
          displaySmall: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: $whiteColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: $greyColor, fontSize: 16),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
            borderSide: BorderSide(color: $greyColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
            borderSide: BorderSide(color: $greyColor),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: $primaryColor,
          selectedItemColor: $whiteColor,
          unselectedItemColor: $greyColor,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const HomeMovieScreen(),
    );
  }
}
