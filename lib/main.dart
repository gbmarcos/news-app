import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routemaster/routemaster.dart';

void main() => runApp(MyApp());

final routes = RouteMap(
  routes: {
    '/': (_) => MaterialPage(child: HomePage()),
    '/profile/:id': (_) => MaterialPage(child: ProfilePage()),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primaryColor: Color(0xFF0C39AC)),
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: RoutemasterParser(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedTab;

  @override
  void initState() {
    //start with first page into tabs
    selectedTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeTransition(
              opacity: primaryAnimation,
              child: child,
            );
          },
          child: getPage()),
      extendBody: true,
      bottomNavigationBar: Material(
        elevation: 10,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedTab,
          onTap: (int value) {
            setState(() {
              selectedTab = value;
            });
          },
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          fixedColor: Color(0xFF111827),
          selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          items: [
            BottomNavigationBarItem(
              label: 'Feed',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );

    // return CupertinoTabScaffold(
    //   controller: tabState.controller,
    //   tabBuilder: tabState.tabBuilder,
    //   tabBar: CupertinoTabBar(
    //     items: [
    //       BottomNavigationBarItem(
    //         label: 'Feed',
    //         icon: Icon(CupertinoIcons.list_bullet),
    //       ),
    //       BottomNavigationBarItem(
    //         label: 'Settings',
    //         icon: Icon(CupertinoIcons.search),
    //       ),
    //     ],
    //   ),
    // );
  }

  getPage() {
    switch (selectedTab) {
      case 0:
        return FeedPage();
      case 1:
        return FavoritePage();
    }
  }
}

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: AppBar(
              title: Text("Feed"),
              elevation: 0,
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          )),
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Text('Favorite page'),
        ));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Profile page')),
    );
  }
}
