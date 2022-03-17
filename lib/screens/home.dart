import 'package:flutter/material.dart';
import 'package:max_fit/domain/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('MaxFit'),
        leading: const Icon(Icons.fitness_center),
      ),
      //возвращает стейтлесс виджет вокоутЛист
      body: WorkoutsList(),
    );
  }
}

//виджет стейтлесс воркоутЛист
class WorkoutsList extends StatelessWidget {
  WorkoutsList({Key? key}) : super(key: key);

  //объявляем в виджете массив с классами Воркоут
  final workouts = <Workout>[
    Workout(title: 'Test1', author: 'Max1', description: 'test workout1', level: 'beginer'),
    Workout(title: 'Test2', author: 'Max2', description: 'test workout2', level: 'intermidiate'),
    Workout(title: 'Test3', author: 'Max3', description: 'test workout3', level: 'advancet'),
    Workout(title: 'Test4', author: 'Max4', description: 'test workout4', level: 'beginer'),
    Workout(title: 'Test5', author: 'Max5', description: 'test workout5', level: 'intermidiate'),
  ];

  @override
  Widget build(BuildContext context) {
    //билдер листВью
    return ListView.builder(
      //кол-во элементов. совпадает с кол-вом в массиве
      itemCount: workouts.length,
      //в билдер передаем контекст и индекс
      itemBuilder: (context, i){
        //возвращаем видет карточка
        return Card(
          //положение по оси Z. что-то типа z-index из CSS
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(50, 65, 85, 0.9)
            ),
            //листТайл - лемент списка
            child: ListTile(
              //отступ симметричный по горизонтали
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              //то-что слева в листТайл
              leading: Container(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.fitness_center,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                decoration: const BoxDecoration(
                  //добавим 1 рамку справа. В виде полоски
                    border: Border(right: BorderSide(
                        width: 1,
                        color: Colors.white24
                    ))
                ),
              ),
              //заголовок
              title: Text(
                //заголовок берется из массива по индексу, далее ключ тайтл
                workouts[i].title,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleMedium?.color,
                    fontWeight: FontWeight.bold
                ),
              ),
              //то, что будет в конце листТайл
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
              //текст, под основным теском в листТайл
              //там будет в-я сабтайтл, возвращающая Row
              //в нее передаем контекст и текущий элемент массива воркоутс
              subtitle: subtitle(context, workouts[i]),
              onTap: (){},
            ),
          ),
        );
      },
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