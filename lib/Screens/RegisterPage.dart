import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Constant/Constant.dart';
import 'package:untitled1/Models/profile.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _page = 1;
  User user;
  var _nameController = TextEditingController();
  var _surnameController = TextEditingController();
  var _lastnameController = TextEditingController();
  var _cityController = TextEditingController();
  var _descController = TextEditingController();
  var _compController = TextEditingController();
  var _specController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurUser(20);
  }

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
          children: <Widget> [
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
                child: Container(
                    padding: EdgeInsets.only(top: 50, bottom: 30),
                    child: Align(
                        child: CircleAvatar(
                          child:Icon(Icons.person, size: 100, color: Colors.blue),
                          radius: 75,
                          backgroundColor: Colors.white,
                        )
                    ),
                ),
              ),
            SizedBox(height: 30),
            Text(
                'Расскажите нам немного о себе:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                )
            ),
            SizedBox(height:20),
            _pageForm(),
          ]
      )
    );
  }

  Widget _pageForm() {
    var hints = <String>[];
    var heights = <double>[];
    var controllers = <TextEditingController>[];
    String buttonText = 'Далее';
    Function buttonAction = (){};

    switch(_page) {
      case 1:
        hints.addAll(['Укажите имя', 'Укажите фамилию', 'Укажите отчество']);
        heights.addAll([30.0, 50.0]);
        controllers.addAll([_nameController, _surnameController, _lastnameController]);
        break;
      case 2:
        hints.addAll(['Укажите нас.пункт', 'Любая информация о вас']);
        controllers.addAll([_cityController, _descController]);
        if (!user.isDoctor()) {
          buttonText = 'Завершить';
          buttonAction = submitForm;
        }
        break;
      case 3:
        hints.addAll(['Укажите место работы', 'Укажите специальность']);
        controllers.addAll([_compController, _specController]);
        buttonText = 'Завершить';
        buttonAction = submitForm;
    }

    return Column(
      children: <Widget> [
        _input(Icon(Icons.person), hints[0], controllers[0], false),
        _input(Icon(Icons.person), hints[1], controllers[1], false),
        _page == 1 ?
        _input(Icon(Icons.person), hints[2], controllers[2], false)
        : SizedBox(height:0),
        SizedBox(height: heights[0]),
        Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
                'Уже совсем скоро вы станете участником крупнейшего медицинского сообщества!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )
            )
        ),
        SizedBox(height: heights[1]),
        _button(buttonText, buttonAction)
      ]
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure) {
      return Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 20, color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 3
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
                prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconTheme(
                        data: IconThemeData(color: Colors.lightBlue),
                        child: icon
                    )
                )
            ),
          )
      );
  }

  Widget _button(String text, void func()) {
    return
      Padding(
          padding: EdgeInsets.only(left: 100, right: 100, bottom: 20),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              splashColor: Colors.white,
              highlightColor: Colors.white,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)
              ),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(40.0)
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)
                  ),
                ),
              ),
              onPressed: (){
                setState(() {
                  _page++;
                });
                func();
              },
            )
            )
      );
  }

  void submitForm() async {
//    final response = await http.put(
//      API_URL +
//    )
  }

  void getCurUser(int userId) async {
    user = await getUser(userId);
  }

  Future<User> getUser(int userId) async {
    final response = await http.get(
      API_URL + USER_ENDPOINT + userId.toString(),
      headers: <String, String> {}
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception('Внутрення ошибка сервера');
    }
  }
}