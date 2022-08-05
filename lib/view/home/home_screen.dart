import 'package:flutter/material.dart';


import '../../widgets-shared/text_component.dart';
import '../main/main_movie.dart';
import '../ranked/ranked_movie.dart';
import '../search/search_screen.dart';

class HomeMovieScreen extends StatefulWidget {
  const HomeMovieScreen({Key? key}) : super(key: key);

  @override
  State<HomeMovieScreen> createState() => _HomeMovieScreenState();
}

class _HomeMovieScreenState extends State<HomeMovieScreen> {
  int currentIndex = 0;
  List<Widget> $MovieScreens = [
    const MovieScreen(),
    const RankedMovie(),
    const SearchScreen()
  ];
  List<String> title = ["Movies", "Ranked", "Search Movie"];

  void _bindScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: title[currentIndex],
          textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 22),
        ),
      ),
      body: $MovieScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _bindScreen(index);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, size: 25),
            label: "Ranked",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 25),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
