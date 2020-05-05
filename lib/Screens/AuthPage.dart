import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Constant/Constant.dart';

class AuthPage extends StatefulWidget {

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  var isLogin = true;
  String _value;

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 150),
      child: Container(
        child: Align(
          child: Text(
                'HD',
                style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    color:Colors.blue,
                )
          )
        )
      )
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
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

  Widget _button(String text, Future func(String param1, String param2)) {
    return RaisedButton(
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
        func(_loginController.text, _passController.text);
        _loginController.clear();
        _passController.clear();
      },
    );
  }

  Widget _form() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 30),
            child: _input(Icon(Icons.email), 'E-mail', _loginController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: _input(Icon(Icons.lock), 'Password', _passController, true),
          ),
          isLogin?
          Column(
            children: <Widget> [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.only(left: 100, right: 100, bottom: 20),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: _button('Войти', authenticate),
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100, bottom: 10),
                  child: GestureDetector(
                      child: Container(child: Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: 15
                          )
                      ), padding: EdgeInsets.only(left: 0),),
                      onTap: () {
                        setState(() {
                          isLogin = false;
                        });
                      }
                  )
              )
            ]
          )
          : Column(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: DropdownButton(
                    hint: Text('Тип пользователя', style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold,)),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.lightBlueAccent),
                    value: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                    underline: Container(
                      height: 1,
                      color: Colors.lightBlueAccent
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        value: 'Врач',
                        child: Text('Врач',)
                      ),
                      DropdownMenuItem(
                        value: 'Пациент',
                        child: Text('Пациент')
                      )
                    ],
                  )
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100, bottom: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: _button('Далее', register),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 100, right: 100, bottom: 10),
                  child: GestureDetector(
                      child: Container(child: Text(
                          'У меня уже есть аккаунт',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: 15
                          )
                      ), padding: EdgeInsets.only(left: 0),),
                      onTap: () {
                        setState(() {
                          isLogin = true;
                        });
                      }
                  )
              )
            ]
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            _logo(),
            _form(),
          ],
        )
      )
    );
  }

  Future authenticate(String email, String password) async {
    final response = await http.post(
      API_URL + SIGN_IN_ENDPOINT,
      headers: <String, String> {},
      body: jsonEncode(<String, String> {
        'login': email,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      final userId = json.decode(response.body)['id_user'];
      Navigator.pushNamed(context, HOME_PAGE, arguments: userId);
    } else {
      throw Exception('Неверный сочетание логина и пароля');
    }
  }

  Future register(String email, String password) async {
      final response = await http.post(
          API_URL + SIGN_UP_ENDPOINT,
          headers: <String, String>{},
          body: jsonEncode(<String, Object>{
            'login': email,
            'password': password,
            'is_doctor': _value == 'Врач' ? true : false
          })
      );
      if (response.statusCode == 200) {
        final userId = json.decode(response.body)['id_user'];
        Navigator.pushNamed(
            context, REG_PAGE,
            arguments: userId
         );
      } else {
        throw Exception('Попробуйте еще раз');
      }
  }
}