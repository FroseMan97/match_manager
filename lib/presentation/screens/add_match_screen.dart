import 'package:flutter/material.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/presentation/widgets/match_snippet.dart';
import 'package:match_manager/utils/refresh_physics.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  TextEditingController matchNameController;
  TextEditingController matchDateController;
  TextEditingController matchCollectionDateTimeController;
  TextEditingController matchPhotoController;
  PageController pageController;
  String matchName = 'Без названия';
  String matchDate = '';
  String matchCollectionDateTime = '';
  String matchPhoto = '';
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    matchNameController = TextEditingController();
    matchDateController = TextEditingController();
    matchCollectionDateTimeController = TextEditingController();
    matchPhotoController = TextEditingController();
    matchNameController.addListener(() {
      setState(() {
        matchName = matchNameController.text;
      });
    });
    matchDateController.addListener(() {
      setState(() {
        matchDate = matchDateController.text;
      });
    });
    matchPhotoController.addListener(() {
      matchPhoto = matchPhotoController.text;
    });
    matchCollectionDateTimeController.addListener(() {
      matchCollectionDateTime = matchCollectionDateTimeController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание матча'),
      ),
      body: PageView(
        controller: pageController,
        physics: RefreshScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildFirstBody(),
          _buildSecondBody(),
        ],
      ),
    );
  }

  _buildFirstBody() {
    return ListView(
      physics: RefreshScrollPhysics(),
      children: <Widget>[
        MatchSnippet(
          matchName: matchName,
          status: MatchStatus.anons,
          matchDateTime: DateTime.tryParse(matchDate),
          photo: matchPhoto,
          matchCollectionDateTime: DateTime.tryParse(matchCollectionDateTime),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(labelText: 'Название'),
            controller: matchNameController,
            keyboardType: TextInputType.text,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(labelText: 'Начало матча'),
            controller: matchDateController,
            keyboardType: TextInputType.datetime,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(labelText: 'Сбор'),
            controller: matchCollectionDateTimeController,
            keyboardType: TextInputType.datetime,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(labelText: 'Превью (картинка)'),
            controller: matchPhotoController,
            keyboardType: TextInputType.text,
          ),
        ),
        ListTile(
            title: RaisedButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Далее',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
          onPressed: () => pageController.nextPage(
            curve: Curves.easeIn,
            duration: Duration(
              milliseconds: 300,
            ),
          ),
        )),
      ],
    );
  }

  _buildSecondBody() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: RaisedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                Text(
                  'Назад',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: () => pageController.previousPage(
              curve: Curves.easeIn,
              duration: Duration(
                milliseconds: 300,
              ),
            ),
          ),
        )
      ],
    );
  }
}
