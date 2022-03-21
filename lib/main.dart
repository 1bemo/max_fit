import 'package:flutter/material.dart';
import 'package:max_fit/domain/authUser.dart';
import 'package:max_fit/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:max_fit/services/auth.dart';
import 'package:provider/provider.dart';

//мейн делаем асинхронным дял Файрбейс.инициализАпп()
void main() async {
  //НАВЕРНОЕ НУЖНА ДЛЯ СТАБИЛЬНОЙ ЗАГРУЗКИ ФАЙРБЕЙС - хз
  WidgetsFlutterBinding.ensureInitialized();
  //инициализация файрбейс
  await Firebase.initializeApp();

  //запускаем виджет МаксФитАпп
  runApp(const MaxFitApp());
}

//то что запускается первым
class MaxFitApp extends StatelessWidget {
  const MaxFitApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //возвращает СтримПровайдер. Нужен для отслеживания потока авторизации пользователя
    //все ниже по иерархии сможет слушать этот стрим
    return StreamProvider<AuthUser?>.value(
      //АутСервис - это класс, в котором содержится большой объект типа ФайрбейсАут
      //геттер куррентЮзер - обращается к потоку с файрбейс
      //где транслируются данные о входе/выходе пользователя и тд
      value: AuthService().currentUser,
      //ничего не инициализируем. Без этого - ошибка
      initialData: null,
      child: MaterialApp(
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
        //страница которая будет кидать либо на Авторизацию, либо на Главную страницу
        home: const LandingPage(),
      ),
    );
  }
}