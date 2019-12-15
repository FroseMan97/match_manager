import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_manager/data/models/news_model.dart';
import 'package:match_manager/domain/datasources/news_datasource.dart';

class NewsFirestoreDatasourceImpl implements NewsDatasource{
  Firestore _firestore;
  static final String _newsCollectionName = 'news';

  NewsFirestoreDatasourceImpl(){
    _firestore=Firestore.instance;
  }

  @override
  Future<List<NewsModel>> getNews() async {
    final results = await _firestore.collection(_newsCollectionName).getDocuments();
    final newsList = results.documents.map((item) {
      final newID = item.documentID;
      final json = item.data;
      return NewsModel(
        newID: newID,
        body: json['newBody'],
        photo: json['newPhoto'],
      );
    }).toList();
    return newsList;
  }

  @override
  Future<NewsModel> getNew(String newID) async {
    final result = await _firestore.collection(_newsCollectionName).document(newID).get();
    return NewsModel(
      newID: result.documentID,
      body: result.data['body'],
      photo: result.data['photo'],
    );
  }

}