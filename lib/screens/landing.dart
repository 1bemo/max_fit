import 'package:flutter/material.dart';
import 'package:max_fit/domain/authUser.dart';
import 'package:max_fit/screens/authScreen.dart';
import 'package:max_fit/screens/home.dart';
import 'package:provider/provider.dart';

//обычный стейтлесс виджет
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //объявляем переменную, в которую записываем контекст
    final user = Provider.of<AuthUser?>(context);
    //в переменную исЛоггедИн помещаем истину, если юзер не пустой
    bool isLoggedIn = user != null;

    //если юзер не пустой, вернуть экран домашней страницы
    //иначе экран авторизации
    return (isLoggedIn ? const HomePage() : const AuthorizationPage());
  }
}
