import 'package:match_manager/data/models/user_model.dart';

abstract class UsersDatasource {
  Future<List<UserModel>> getUsers();

  Future<UserModel> getUser(String userID);
}