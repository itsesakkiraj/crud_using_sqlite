//the bridge between ui & database repository

import 'package:crud_using_sqlite/db_helper/repository.dart';
import 'package:crud_using_sqlite/models/User.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

//save users
  Saveuser(User user) async {
    return await _repository.insertData("users", user.Usermap());
  }

  //read all users
  readuser() async {
    return await _repository.readData("users");
  }

  Updateuser(User user) async {
    return await _repository.UpdateData("users", user.Usermap());
  }

  deleteUser(userId) async {
    return await _repository.deletedata("users", userId);
  }
}
