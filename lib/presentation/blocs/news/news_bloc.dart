import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:match_manager/domain/repositories/news_repository.dart';
import 'package:match_manager/presentation/blocs/news/news_event.dart';
import 'package:match_manager/presentation/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository}){
    add(LoadNewsEvent());
  }

  @override
  // TODO: implement initialState
  NewsState get initialState => LoadingNewsState();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is LoadNewsEvent) {
      yield LoadingNewsState();
      try {
        final news = await newsRepository.getNews();
        if (news == null || news.isEmpty) {
          yield EmptyNewsState();
        } else {
          yield LoadedNewsState(news);
        }
      } catch (error) {
        yield ErrorNewsState(error.toString());
      }
    }
  }
}
