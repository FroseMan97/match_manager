import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_manager/data/datasources/news_firestore_datasource_impl.dart';
import 'package:match_manager/data/models/news_model.dart';
import 'package:match_manager/data/repositories/news_firestore_datasource_impl.dart';
import 'package:match_manager/domain/datasources/news_datasource.dart';
import 'package:match_manager/domain/repositories/news_repository.dart';
import 'package:match_manager/presentation/blocs/news/news_bloc.dart';
import 'package:match_manager/presentation/blocs/news/news_event.dart';
import 'package:match_manager/presentation/blocs/news/news_state.dart';
import 'package:match_manager/presentation/widgets/base_snippet.dart';
import 'package:match_manager/presentation/widgets/drawer.dart';
import 'package:match_manager/utils/refresh_physics.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScrennState createState() => _NewsScrennState();
}

class _NewsScrennState extends State<NewsScreen> {
  NewsBloc newsBloc;

  @override
  void didChangeDependencies() {
    NewsDatasource newsDatasource = NewsFirestoreDatasourceImpl();
    NewsRepository newsRepository =
        NewsRepositoryImpl(newsDatasource: newsDatasource);
    newsBloc = NewsBloc(newsRepository: newsRepository);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) => newsBloc,
      child: Scaffold(
        drawer: DrawerWidget(
          news: true,
        ),
        body: CustomScrollView(
          physics: RefreshScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Новости'),
            ),
            CupertinoSliverRefreshControl(
                refreshIndicatorExtent: 80,
                onRefresh: () async {
                  await Future.delayed(
                    Duration(seconds: 1),
                  );
                  newsBloc.add(LoadNewsEvent());
                }),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is LoadedNewsState) {
                  return _buildBody(state.news);
                }
                if (state is LoadingNewsState) {
                  return _buildLoading();
                }
                if (state is ErrorNewsState) {
                  return _buildError(state.error);
                }
                return SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  _buildError(String error) {
    return SliverFillRemaining(
      child: Center(
        child: Text(error),
      ),
    );
  }

  _buildLoading() {
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _buildBody(List<NewsModel> news) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (
          context,
          i,
        ) {
          return BaseSnippet(
            needPhoto: true,
            photo: news[i].photo,
            child: Text('${news[i].body}'),
          );
        },
        addAutomaticKeepAlives: false,
        childCount: news?.length
      ),
    );
  }
}
