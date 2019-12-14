import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_manager/presentation/blocs/theme/theme_bloc.dart';
import 'package:match_manager/presentation/blocs/theme/theme_event.dart';
import 'package:match_manager/presentation/theme/custom_theme.dart';

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
    final avatar =
        'https://cdn21.img.ria.ru/images/155971/99/1559719951_0:158:3072:1886_600x0_80_0_0_73ccb99791b35c1e1c63c6253d862267.jpg';
    return Drawer(
      child: Container(
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.list),
              title: Text(
                'Матчи',
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.dashboard),
              title: Text(
                'Задания',
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(Icons.accessibility),
              title: Text(
                'Очередь',
              ),
            ),
            _buildThemeTile(),
            _buildExitTile(),
          ],
        ),
      ),
    );
  }

  _buildExitTile() {
    return ListTile(
      onTap: () => null,
      leading: Icon(Icons.exit_to_app),
      title: Text(
        'Выйти',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  _buildThemeTile() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: ListTile(
          leading: Icon(Icons.add_to_home_screen),
          title: Text(
            'Темная тема',
          ),
          trailing: _buildSwitch(),
        ),
      ),
    );
  }

  _buildSwitch() {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeData>(
      bloc: themeBloc,
      builder: (context, theme) {
        return CupertinoSwitch(
          value: theme == CustomTheme.darkTheme,
          onChanged: (newValue) {
            themeBloc.add(
              SetThemeEvent(
                isDarkTheme: newValue,
              ),
            );
          },
        );
      },
    );
  }
}
