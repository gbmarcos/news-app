import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:news_app/local_storage/client.dart';
import 'package:news_app/models/article_model.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class ArticleCard extends StatefulWidget {
  final ArticleModel article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ColumnSuper(
        innerDistance: -20,
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/placeholder_2.jpg",
            image: /*widget.article.imageUrl ??*/ "http",
          ),
          Material(
            elevation: 10,
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.article.title ?? "-",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Color(0xFF6B7280),
                        size: 20,
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                        width: 10,
                      ),
                      Text(
                        widget.article.publishedAt != null
                            ? DateFormat.yMMMMd('en_US').format(widget.article.publishedAt!)
                            : "-",
                        style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                        width: 26,
                      ),
                      buildFavoriteButton()
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFavoriteButton() {
    int? articleId = widget.article.id;

    return IconButton(
      icon: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: favoriteArticleBox.containsKey(articleId)
            ? Icon(
                Icons.favorite,
                key: ValueKey<bool>(true),
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.favorite_border,
                key: ValueKey<bool>(false),
                color: Color(0xFF6B7280),
              ),
        transitionBuilder: (child, animation) {
          return FadeScaleTransition(
            child: child,
            animation: animation,
          );
        },
      ),
      onPressed: () {
        if (favoriteArticleBox.containsKey(articleId)) {
          favoriteArticleBox.delete(articleId);
        } else {
          favoriteArticleBox.put(articleId, "");
        }
        setState(() {});
      },
    );
  }
}
