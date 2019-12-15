import 'package:flutter/foundation.dart';
import 'package:match_manager/data/models/news_model.dart';
import 'package:match_manager/domain/datasources/news_datasource.dart';
import 'package:match_manager/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDatasource newsDatasource;

  NewsRepositoryImpl({
    @required this.newsDatasource,
  });

  @override
  Future<NewsModel> getNew(String newID) {
    return newsDatasource.getNew(newID);
  }

  @override
  Future<List<NewsModel>> getNews() {
    return newsDatasource.getNews();
  }
}
