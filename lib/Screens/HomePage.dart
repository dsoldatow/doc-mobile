import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Constant/Constant.dart';
import 'package:untitled1/Models/profile.dart';

class HomePage extends StatefulWidget {
  static const routeName = HOME_PAGE;

  HomePage({Key key}) : super(key: key);

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context).settings.arguments;
    var _searchController = TextEditingController();

    return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xff154AAA), Color(0xff64B6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    children: <Widget> [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Container(
                                height: 50,
                                width: 250,
                                margin: EdgeInsets.only(left: 25),
                                padding: EdgeInsets.only(left:15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                ) ,
                                child:TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                      hintText: 'Поиск',
                                      icon: Icon(Icons.search),
                                      border: InputBorder.none
                                  ),
                                  onEditingComplete: (){
                                    Navigator.pushNamed(context, SEARCH_PAGE, arguments: _searchController.text);
                                    _searchController.clear();
                                  },
                                )
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100)
                                ),
                                image: DecorationImage(image: AssetImage("assets/images/as.png"), )
                              )
                            )
                          ]
                      ),
                    ]
                  ),
                ),
              ]
            )
        );
  }
}