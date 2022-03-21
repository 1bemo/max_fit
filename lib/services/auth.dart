import 'package:firebase_auth/firebase_auth.dart';
import 'package:max_fit/domain/authUser.dart';

//класс сервиса авторизации/регистрации
class AuthService {
  //в _фАут помещаем большой объект из ФайрбейсАут
  //который содержит много чего по авторизации, регистрации и тд
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  //метод асинхр войтиСЕмайлИПароль. Принимает строки емайл и пароль
  //возвращает объект Фьючер
  Future signInWithEmailAndPassword(String email, String password) async {
    //трай на случай ошибки
    try {
      //в результ помещаем объект, типа ЮзерКреденшинал из большого объекта файрбейс
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //в юзер, типа Юзер(которая может быть нул) помещаем вышеобъявленную результ.юзер
      User? user = result.user;
      //возвращаем метод фромФайрбейс из класса АутЮзер из файла domain/authUser.dart
      //в которые помещаем объект юзер
      //собственно этот метод авторизирует
      return AuthUser.fromFirebase(user);
    } catch (e) {
      //вернуть нул, если какая-то ошибка
      return null;
    }
  }

  //все, как выше в signInWithEmailAndPassword(), только в результ помещаем данные
  //из метода криейтЮзерВизЕмайлПассворд
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;
      return AuthUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  //метод логаут - выход из файрбейс
  Future logOut() async {
    //используем метод сигнАут из большого объекта _фАут
    await _fAuth.signOut();
  }

  //очень важный геттер, который возвращает данные из потока аутСтейтЧенджес
  //в этом потоке транслируются данные о том залогинен ли пользователь или нет и тд
  Stream<AuthUser?> get currentUser {
    //в большом объекте _фАут используем поток аутСтейтЧенджес
    return _fAuth.authStateChanges()
        //далее метод Мэп в нем ф-я. Если юзер не пустой, возвращает авторизацию
        //иначе возвращает нул
        .map((user) => user != null ? AuthUser.fromFirebase(user) : null);
  }

}