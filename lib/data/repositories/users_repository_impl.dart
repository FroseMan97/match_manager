
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/domain/datasources/users_datasource.dart';
import 'package:match_manager/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {

  final UsersDatasource usersDatasource;

  UsersRepositoryImpl(this.usersDatasource);

  @override
  Future<UserModel> getUser(String userID) {
    return usersDatasource.getUser(userID);
  }

  @override
  Future<List<UserModel>> getUsers() {
    return usersDatasource.getUsers();
  }
  
}