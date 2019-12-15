import 'package:match_manager/data/models/news_model.dart';

abstract class NewsState{}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<NewsModel> news;
  LoadedNewsState(this.news);
}

class EmptyNewsState extends NewsState {}

class ErrorNewsState extends NewsState {
  final String error;
  ErrorNewsState(this.error);
}