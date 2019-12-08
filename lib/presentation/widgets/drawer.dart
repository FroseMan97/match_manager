import 'package:flutter/material.dart';
import 'package:match_manager/styles.dart';

import 'user_account_drawer_header.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final userName = 'Sergey Lazarev';
    final email = 'iazarev@yahoo.com';
    final avatar = 'https://cdn21.img.ria.ru/images/155971/99/1559719951_0:158:3072:1886_600x0_80_0_0_73ccb99791b35c1e1c63c6253d862267.jpg';
    return Drawer(
      child: Container(
        color: CustomStyles.drawerColor,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserDrawerHeader(
              userName: userName,
              email: email,
              avatar: avatar,
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.new_releases),
              title: Text(
                'Новости',
                style: CustomStyles.drawerListTile,
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.list),
              title: Text(
                'Матчи',
                style: CustomStyles.drawerListTile,
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.dashboard),
              title: Text(
                'Задания',
                style: CustomStyles.drawerListTile,
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.accessibility),
              title: Text(
                'Очередь',
                style: CustomStyles.drawerListTile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
