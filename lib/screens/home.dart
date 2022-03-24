import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:max_fit/domain/workout.dart';
import 'package:max_fit/services/auth.dart';

import '../components/activeWorkouts.dart';
import '../components/workoutList.dart';

//для игнорирования незначительных ошибок
// ignore: must_be_immutable
//стейтфул для перерисовки боди
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //индекс для БоттомНавигаторБар
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        //к МаксФит // лепим от условия (если секшонИндекс=0, пишем Актив. иначе Файнд)
        title: Text('MaxFit // ' + (sectionIndex==0 ? 'Active ' : 'Find')),
        leading: const Icon(  Icons.fitness_center),
        actions: [
          IconButton(
            tooltip: 'LogOut',
            onPressed: (){
              //логаут из пользователя
              AuthService().logOut();
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      //в боди условие (если индекс=0,отрисовываем АктивВоркаут, иначе ВоркаутЛист)
      body: sectionIndex == 0 ? const ActiveWorkouts() : const WorkoutsList(),
      //подключаемый красивый навигаторБар
      bottomNavigationBar: CurvedNavigationBar(
        //айтемс - кнопки
        items: const <Widget>[
          Icon(Icons.fitness_center),
          Icon(Icons.search)
        ],
        //индекс кнопок. Отсчет с нуля
        index: sectionIndex,
        //высота
        height: 50,
        //цвета
        color: Colors.black.withOpacity(0.3),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        //анимация по кривой из класса Кривые
        animationCurve: Curves.easeInOutCubic,
        //скорость анимации
        animationDuration: const Duration(milliseconds: 300),
        //при нажатии сетСтейт в переменную секшнИндекс приписываем индекс
        //из ф-ии теккущей
        onTap: (int index){
          setState(() {
            sectionIndex = index;
          });
        },
      ),
    );
  }
}

Widget subtitle(BuildContext context, Workout workout) {
  //цвет по умолчанию
  var color = Colors.grey;
  //позиция ползунка по умолчанию. от 0 до 1
  double indicatorLevel = 0;

  //переключатель по воркоут.левел
  switch(workout.level) {
  //если бегиннер
    case 'beginer':
    //в колор кладем зеленый цвет
      color = Colors.green;
      //в индикаторлевел 0,33 и тд
      indicatorLevel = 0.33;
      break;
    case 'intermidiate':
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    case 'advancet':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }

  //возвращаем Роу
  return Row(
    //что наодится в строке
    children: [
      //растягиваемыйы бокс Экспандед с размером 1 (из 4х)
      Expanded(
          flex: 1,
          //виджет полоска, как прогрессБар
          child: LinearProgressIndicator(
            //цвет заднего фона, как у всего ЛистТайл ,чтобы они слились
            backgroundColor: Theme.of(context).textTheme.titleMedium?.color,
            //длина прогрессБара в double
            value: indicatorLevel,
            //цвет полоски брогрессБара
            //но, т.к цвет напрямую не передается, использется виджет
            //АлвайсСтопАнимейшн - всегда останавливать анимацию
            //в общем анимации не будет. В нее уже передаем переменную колор
            valueColor: AlwaysStoppedAnimation(color),
          )
      ),
      //виджет между 1м експандедом и 2м
      const SizedBox(
        width: 10,
      ),
      //растягиваемыйы бокс Экспандед с размером 3 (из 4х)
      Expanded(
          flex: 3,
          //просто текст
          child: Text(
            //берем из текущего воркоут.левел - название уровня
            workout.level,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium?.color
            ),
          )
      )
    ],
  );
}