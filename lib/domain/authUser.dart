import 'package:firebase_auth/firebase_auth.dart';

//класс аутЮзер
class AuthUser{
  //строковая ид
  String? id;

  //метод фромФайрбейс, поключается импортом файрбейсАут. Помещает в ид юзер.юид
  AuthUser.fromFirebase(User? user) {
    id = user?.uid;
  }
}