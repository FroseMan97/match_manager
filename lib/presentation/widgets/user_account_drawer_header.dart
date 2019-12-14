import 'package:flutter/material.dart';

import '../../constants.dart';

class UserDrawerHeader extends StatelessWidget {
  final String userName;
  final String email;
  final String avatar;

  UserDrawerHeader(
      {@required this.userName, @required this.email, @required this.avatar});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                HEADER_IMAGE_ASSET_STRING,
              ),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken))),
      accountName: Text(
        userName,
      ),
      accountEmail: Text(
        email,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
    );
  }
}
