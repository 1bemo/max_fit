import 'package:flutter/material.dart';

import '../domain/workout.dart';
import '../screens/home.dart';

//виджет стейтлесс воркоутЛист
class WorkoutsList extends StatelessWidget {
  WorkoutsList({Key? key}) : super(key: key);

  //объявляем в виджете массив с классами Воркоут
  final workouts = <Workout>[
    Workout(
        title: 'Test1',
        author: 'Max1',
        description: 'test workout1',
        level: 'beginer')
    ,
    Workout(
        title: 'Test2',
        author: 'Max2',
        description: 'test workout2',
        level: 'intermidiate'
    ),
    Workout(
        title: 'Test3',
        author: 'Max3',
        description: 'test workout3',
        level: 'advancet'
    ),
    Workout(
        title: 'Test4',
        author: 'Max4',
        description: 'test workout4',
        level: 'beginer'
    ),
    Workout(
        title: 'Test5',
        author: 'Max5',
        description: 'test workout5',
        level: 'intermidiate'
    ),
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
              //color: Color.fromRGBO(50, 65, 85, 0.9)
                color: Colors.blueAccent
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
              onTap: (){

              },
            ),
          ),
        );
      },
    );
  }
}