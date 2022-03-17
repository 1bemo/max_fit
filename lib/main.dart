import 'package:flutter/material.dart';
import 'package:max_fit/screens/auth.dart';
import 'package:max_fit/screens/home.dart';

void main() => runApp(const MaxFitApp());

class MaxFitApp extends StatelessWidget {
  const MaxFitApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Max Fitness',
      //тема
      theme: ThemeData(
        //главный цвет
        primaryColor: const Color.fromRGBO(50, 65, 85, 1),
        //цвет текстов
        textTheme: const TextTheme(
          //у тайтлМедиум свой стиль
          titleMedium: TextStyle(
            color: Colors.white,
          )
        ),
      ),
      home: const AuthorizationPage(),
    );
  }
}