import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/pages/article_detail_page.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:routemaster/routemaster.dart';

void main() => runApp(MyApp());

final routes = RouteMap(
  routes: {
    '/': (_) => MaterialPage(child: HomePage()),
    '/detail/:id': (_) => MaterialPage(child: ArticleDetailPage()),
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




