import 'package:match_manager/data/models/news_model.dart';

abstract class NewsDatasource {
  Future<List<NewsModel>> getNews();
  Future<NewsModel> getNew(String newID);
}