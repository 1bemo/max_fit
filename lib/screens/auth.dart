import 'package:flutter/material.dart';

//класс, наследующий от КастомСлиппер
//рисует кривую безье --ПРОСТО ЗАПОМНИТЬ--
class BottomWaveClipper extends CustomClipper<Path> {

  //ф-я гетКлип, возвращающая объект типа Патч
  @override
  Path getClip(Size size) {
    //переменная патч - новый Путь
    var path = Path();

    //отрисовка безье
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width/6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    //вернуть то, нарисовали
    return path;
  }

  //обязательный оверрайд - ставим в ложь
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//главный стейтфул виджет
class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {

  //текст-контроллеры для полей ввода емайл и пароль
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //в них присваивается значение после нажатия кнопки
  String? _email;
  String? _password;

  //показывать надпись ЛОГИН ? или Регистрация
  bool showlogin = true;

  @override
  Widget build(BuildContext context) {

    //возвращает виджет с логотипом
    Widget _logo() {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        //Алигн - центрирует по центру по-умолчанию (аналог Центр)
        child: Align(
          child: Text(
            'MAXFIT',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      );
    }

    //возвращает поле для ввода. Принимает иконку слева, подсказку, контроллер и булево - прятать ввод или нет
    Widget _input (Icon icon, String hint, TextEditingController controller, bool obscure) {
      return Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextField(
          //контроллер
          controller: controller,
          //прятать текст или нет
          obscureText: obscure,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white30
            ),
            //подсказка
            hintText: hint,
            //рамка при фокусе - толстая
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3
              ),
            ),
            //рамка в обычном состоянии - тонкая
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white54,
                    width: 1
                ),
            ),
            //иконка, вставленная через IconTheme, чтобы менять в ней цвет
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: icon,
              ),
            ),
          ),
        ),
      );
    }

    //возвращает виджет кнопку. Принимает текст для кнопки и ф-ю дял нажатия на нее
    Widget _button(String text, void Function() func) {
      return ElevatedButton(
        style: ButtonStyle(
          //цвет фона кнопки
          backgroundColor: MaterialStateProperty.all(Colors.white),
          //цвет сплеша при нажатии на кнопку
          overlayColor: MaterialStateProperty.all(Colors.black38),
        ),
        //splashColor: Theme.of(context).primaryColor,
        //highlightColor: Theme.of(context).primaryColor,
        //color: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 20
          ),
        ),
        onPressed: (){
          func();
        },
      );
    }

    //виджет - вся форма: логин+пароль+кнопка
    Widget _form(String label, void Function() func) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 10),
            //поле ввода емайл
            child: _input(const Icon(Icons.email),'EMAIL',_emailController,false),
            //child: Text('some1'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            //поле ввода пароль
            child: _input(const Icon(Icons.lock),'PASSWORD',_passwordController,true),
            //child: Text('some2'),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              //кнопка. передаем в нее текст кнопки и ф-ю
              child: _button(label,func),
            ),
          )
        ],
      );
    }

    //ф-я действие кнопки
    void _buttonAction(){
      //в переменные присваиваем из контроллера-текст
      _email = _emailController.text;
      _password = _passwordController.text;

      //после присваивания очищаем контроллеры
      _emailController.clear();
      _passwordController.clear();
    }

    //возвращает кривую безье
    Widget _bottomWave() {
      return Expanded(
          child: Align(
            child: ClipPath(
              child: Container(
                color: Colors.white,
                height: 300,
              ),
              //рисует кривую безье
              clipper: BottomWaveClipper(),
            ),
            alignment: Alignment.bottomCenter,
          )
      );
    }

    //главный скафолд страницы
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          //логотип
          _logo(),
          const SizedBox(
            height: 100,
          ),
          //интересная условная конструкция
          //типа (showlogin ? Column() : Column() )
          //если showlogin истина - вставляется 1й столбец ,иначе вставляется 2й столбец
          (
            showlogin ?
                Column(
                  children: [
                    //форма с кнопкой ЛОГИН и ф-ей баттонЭкшн
                    //ф-я кнопок одна и та же: записать значения полей в переменные и очистить поля
                    _form('LOGIN', _buttonAction),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      //ГестурДетектор - что-то типа ТекстБаттон. Кликабельный текст с onTap()
                      child: GestureDetector(
                        child: const Text(
                          'Not registered yet? Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: (){
                          //меняем showlogin с перерисовкой. В итоге отрисовывется второй столбец из условия
                          setState(() {
                            showlogin = false;
                          });
                        },
                      ),
                    )
                  ],
                )
            : Column(
              children: [
                //форма с кнопкой РЕГИСТЕР и ф-ей баттонЭкшн
                //ф-я кнопок одна и та же: записать значения полей в переменные и очистить поля
                _form('REGISTER', _buttonAction),
                Padding(
                  padding: const EdgeInsets.all(10),
                  //ГестурДетектор - что-то типа ТекстБаттон. Кликабельный текст с onTap()
                  child: GestureDetector(
                    child: const Text(
                      'Already registered? login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: (){
                      //меняем showlogin с перерисовкой. В итоге отрисовывется первый столбец из условия
                      setState(() {
                        showlogin = true;
                      });
                    },
                  ),
                )
              ],
            )
          ),
          //отрисовка линии безье внизу
          _bottomWave(),
        ],
      ),
    );
  }
}