import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:match_manager/data/models/user_model.dart';

class UsersLocalDatasourceImpl {
  Future<List<UserModel>> getUsers() async {
  final jsonMap = jsonDecode(await rootBundle.loadString('mock/users_mock.json'));
    final usersList = jsonMap['users'] as List;
    List<UserModel> matchesModelList = List<UserModel>();
    usersList.forEach((item) {
      matchesModelList.add(UserModel.fromJson(item));
    });
    return matchesModelList;
  }

  Future<UserModel> getUser(String userID) async {
    final users = await getUsers();
    return users.firstWhere((user) => user.userID == userID, orElse: () => null);
  }
}