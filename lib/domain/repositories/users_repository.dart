import 'package:match_manager/data/models/user_model.dart';

abstract class UsersRepository {
  Future<UserModel> getUser(String userID);
  Future<List<UserModel>> getUsers();
}