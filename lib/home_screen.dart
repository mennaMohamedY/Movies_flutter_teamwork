import 'package:flutter/material.dart';
import 'package:movies_app/BrowseTab/categories_screen.dart';
import 'package:movies_app/Themes.dart';
import 'package:movies_app/homeTab/homeTab.dart';
import 'package:movies_app/searchTab/searchTab.dart';
import 'package:movies_app/watchListTab/watchlistTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> Tabs = [
    HomeTab(),
    SearchTab(),
    CategoriesScreen(),
    WatchListTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(
          //   "Movies",
          //   style: Theme.of(context)
          //       .textTheme
          //       .titleLarge!
          //       .copyWith(color: MyTheme.whiteColor),
          // ),
          toolbarHeight: 0,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: MyTheme.bottomNav),
          child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(color: MyTheme.yellowColor),
              currentIndex: selectedIndex,
              selectedIconTheme: IconThemeData(
                  size: MediaQuery.of(context).size.height * 0.05,
                  color: MyTheme.yellowColor),
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/home.png')),
                    label: ''),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/Search.png')),
                    label: ''),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/Browse.png')),
                    label: ''),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/watchlist.png')),
                    label: '')
              ]),
        ),
        body: Tabs[selectedIndex]);
  }
}
