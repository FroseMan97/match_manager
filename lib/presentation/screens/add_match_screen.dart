import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_manager/data/models/match_model.dart';
import 'package:match_manager/data/models/match_status_model.dart';
import 'package:match_manager/presentation/blocs/add_match/add_match_bloc.dart';
import 'package:match_manager/presentation/blocs/add_match/add_match_event.dart';
import 'package:match_manager/presentation/blocs/add_match/add_match_state.dart';
import 'package:match_manager/presentation/widgets/full_match_snippet.dart';
import 'package:match_manager/presentation/widgets/match_snippet.dart';
import 'package:match_manager/utils/refresh_physics.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  TextEditingController matchNameController;
  TextEditingController matchDescriptionController;
  TextEditingController matchDateController;
  TextEditingController matchCollectionDateTimeController;
  TextEditingController matchPhotoController;
  PageController pageController;

  AddMatchBloc addMatchBloc;

  @override
  void initState() {
    super.initState();
    addMatchBloc = AddMatchBloc();
    pageController = PageController(initialPage: 0);
    matchDescriptionController = TextEditingController();
    matchNameController = TextEditingController();
    matchDateController = TextEditingController();
    matchCollectionDateTimeController = TextEditingController();
    matchPhotoController = TextEditingController();
    matchDescriptionController.addListener(() {
      addMatchBloc.add(
        SetMatchInfoEvent(
          matchDescription: matchDescriptionController.text,
        ),
      );
    });
    matchNameController.addListener(() {
      addMatchBloc.add(
        SetMatchInfoEvent(
          matchName: matchNameController.text,
        ),
      );
    });
    matchDateController.addListener(() {
      addMatchBloc.add(
        SetMatchInfoEvent(
          matchDate: matchDateController.text,
        ),
      );
    });
    matchCollectionDateTimeController.addListener(() {
      addMatchBloc.add(
        SetMatchInfoEvent(
          matchCollectionDateTime: matchCollectionDateTimeController.text,
        ),
      );
    });
    matchPhotoController.addListener(() {
      addMatchBloc.add(
        SetMatchInfoEvent(
          matchPhoto: matchPhotoController.text,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание матча'),
      ),
      body: BlocProvider<AddMatchBloc>(
        create: (context) => addMatchBloc,
        child: BlocBuilder<AddMatchBloc, SettedMatchState>(
          builder: (context, state) {
            return PageView(
              controller: pageController,
              physics: RefreshScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildFirstBody(state),
                _buildSecondBody(state),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildFirstBody(SettedMatchState state) {
    return ListView(
      physics: RefreshScrollPhysics(),
      children: <Widget>[
        MatchSnippet(
          matchDescription: state.matchDescription,
          matchName: state.matchName,
          status: MatchStatus.anons,
          matchDateTime: state.matchDate,
          photo: state.matchPhoto,
          matchCollectionDateTime: state.matchCollectionDateTime,
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              labelText: 'Превью (картинка)',
            ),
            controller: matchPhotoController,
            keyboardType: TextInputType.url,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              labelText: 'Название',
              helperText: 'Например, ЗЕНИТ - АХМАТ'
            ),
            maxLength: 60,
            controller: matchNameController,
            keyboardType: TextInputType.text,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              labelText: 'Начало матча',
              helperText: 'Например, 2020-12-31 19:30'
            ),
            controller: matchDateController,
            keyboardType: TextInputType.datetime,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              labelText: 'Сбор',
              helperText: 'Например, 2020-12-31 19:30'
            ),
            controller: matchCollectionDateTimeController,
            keyboardType: TextInputType.datetime,
          ),
        ),
        ListTile(
          title: TextField(
            decoration: InputDecoration(
              labelText: 'Комментарий',
              
            ),
            maxLength: 300,
            controller: matchDescriptionController,
            enableInteractiveSelection: true,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
        ),
        ListTile(
            title: RaisedButton(
          color: Colors.red,
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

  _buildSecondBody(SettedMatchState state) {
    return CustomScrollView(
      physics: RefreshScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: ListTile(
            title: RaisedButton(
              color: Colors.orange,
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
          ),
        ),
        FullMatchSnippet(
          matchCollectionDateTime: state.matchCollectionDateTime,
          matchDateTime: state.matchDate,
          matchDescription: state.matchDescription,
          matchName: state.matchName,
          matchPhoto: state.matchPhoto,
          matchStatus: MatchStatus.anons,
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: RaisedButton(
              color: Colors.green,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  Text(
                    'Сохранить',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    );
  }
}
