import 'package:flutter/material.dart';
import 'package:untitled1/Constant/Constant.dart';
import 'package:untitled1/Models/profile.dart';

class SearchPage extends StatefulWidget {

  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String searchString = ModalRoute.of(context).settings.arguments;
    _searchController.text = searchString;

    return Container(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
                title: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: 'Поиск',
                      icon: Icon(Icons.search),
                      border: InputBorder.none
                  ),
                ),
                leading: Icon(Icons.arrow_back_ios)
            ),
            body: ProfilesList()
        )
    );
  }
}


class ProfilesList extends StatelessWidget {
  final profiles = <User>[
    User(userId: 1, name: 'Vanya', spec: 'spec1'),
    User(userId:2, name:'Denis', spec: 'spec2'),
  ];

  @override
  Widget build(BuildContext context) {
  return Container(
    child: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, i){
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(),
            child: Container(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.pink,
                      size: 56
                  )
                ),
                title: Text(profiles[i].name),
                subtitle: Text(profiles[i].spec),
                onTap: (){Navigator.pushNamed(context, PROFILE_PAGE);},
              )
            )
          );
        }
    )
  );
  }
}
