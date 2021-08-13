import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_service/client.dart';
import 'package:news_app/api_service/repositories/article_repository.dart';
import 'package:news_app/models/article_model.dart';

class ArticleCubit extends Cubit<List<ArticleModel>?> {
  final int limit = 10;

  ArticleCubit() : super(null);

  Future<void> loadArticles({String? contains, List? favoriteIdList}) async {
    //todo: explain
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(<ArticleModel>[]);
      return;
    }

    Map? response = await ArticleRepository(dioClient: dioClient).getArticles(
      start: 0,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );

    if (response != null) {
      emit((response["data"] as List<ArticleModel>?));
    }
  }

  Future<void> loadMoreArticles({String? contains, List? favoriteIdList}) async {
    //todo: explain
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(<ArticleModel>[]);
      return;
    }

    int start = state?.length ?? 0;
    print("loading more");
    Map? response = await ArticleRepository(dioClient: dioClient).getArticles(
      start: start,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );
    if (response != null) {
      if (state != null) {
        List<ArticleModel> newState = state! + (response["data"] as List<ArticleModel>?)!;
        emit(newState);
      } else {
        emit((response["data"] as List<ArticleModel>?));
      }
    }
  }

  clear() {
    emit(null);
  }
}
