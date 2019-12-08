import 'package:match_manager/data/datasources/users_local_datasource_impl.dart';
import 'package:match_manager/data/models/user_model.dart';
import 'package:match_manager/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {

  final UsersLocalDatasourceImpl usersLocalDatasourceImpl;

  UsersRepositoryImpl(this.usersLocalDatasourceImpl);

  @override
  Future<UserModel> getUser(String userID) {
    return usersLocalDatasourceImpl.getUser(userID);
  }

  @override
  Future<List<UserModel>> getUsers() {
    return usersLocalDatasourceImpl.getUsers();
  }
  
}