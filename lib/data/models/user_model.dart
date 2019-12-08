import 'package:flutter/cupertino.dart';

class UserModel {
   final String userID;
   final String fullName;
   final String phone;
   final String avatar;

  UserModel({
    @required this.userID,
    @required this.fullName,
    @required this.phone,
    @required this.avatar
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    if(json == null) {
      throw Exception('Ну помойка какая-то, такого точно быть не должно');
    }
    return UserModel(
      userID: json['userID'],
      fullName: json['fullName'],
      phone: json['phone'],
      avatar: json['avatar']
    );
  }
}