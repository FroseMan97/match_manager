import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_manager/presentation/widgets/base_snippet.dart';
import 'package:match_manager/presentation/widgets/drawer.dart';
import 'package:match_manager/utils/refresh_physics.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScrennState createState() => _NewsScrennState();
}

class _NewsScrennState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onRefresh: () async => await Future.delayed(
              Duration(seconds: 1),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              return BaseSnippet(
                needPhoto: true,
                child: Text('Application'),
              );
            }),
          )
        ],
      ),
    );
  }
}
