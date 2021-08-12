import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late bool searching;
  late Duration transitionDuration;
  late Curve transitionCurve;
  late TextEditingController searchController;

  @override
  void initState() {
    searching = false;
    transitionDuration = Duration(milliseconds: 250);
    transitionCurve = Curves.decelerate;
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = searching ? "Search" : "Favorite";
    String titleKey = searching ? "title2" : "title1";
    TextStyle titleStyle = TextStyle(fontSize: 18);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: AppBar(
              title: AnimatedSwitcher(
                duration: transitionDuration,
                switchInCurve: transitionCurve,
                switchOutCurve: transitionCurve,
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                    alignment: Alignment.topLeft,
                  );
                },
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  key: ValueKey<String>(titleKey),
                  style: titleStyle,
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: transitionDuration,
                    switchInCurve: transitionCurve,
                    switchOutCurve: transitionCurve,
                    transitionBuilder: (child, animation) {
                      return FadeScaleTransition(
                        child: child,
                        animation: animation,
                      );
                    },
                    child: searching
                        ? Icon(
                      Icons.close,
                      key: ValueKey<String>("icon2"),
                    )
                        : Icon(
                      Icons.search,
                      key: ValueKey<String>("icon1"),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (searching) {
                        searchController.clear();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                      searching = !searching;
                    });
                  },
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                )
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            clipBehavior: Clip.none,
            height: searching ? 70 : 0,
            duration: transitionDuration,
            curve: transitionCurve,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white.withOpacity(0.8),
                    cursorWidth: 1,
                    cursorHeight: 18,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      print("searching");
                    },
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      fillColor: Colors.black.withOpacity(0.3),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
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