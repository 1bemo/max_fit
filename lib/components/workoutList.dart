import 'package:flutter/material.dart';

import '../domain/workout.dart';
import '../screens/home.dart';

//виджет стейтфул воркоутЛист
class WorkoutsList extends StatefulWidget {
  const WorkoutsList({Key? key}) : super(key: key);

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {

  //при инициализации
  @override
  void initState(){
    //выполняем ф-ю клеарФильтер()
    clearFilter();
    super.initState();
  }

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

  //перем. выключателя - толькоМоиВоркауты
  bool filterOnlyMyWorkouts = false;
  //перем. для хранения ручного ввода
  String filterTitle = '';
  //текстовый контроллер
  var filterTitleController = TextEditingController();
  //перем. выпадающего списка
  var filterLevel = 'Any Level';
  //перем. с иконкой стрелочкой вниз, чтобы менять на стрелочку вверх
  IconData filterIcon = Icons.keyboard_arrow_down;
  //общий текст в фильтре
  var filterText = '';
  //перем. с высотой АниматедКонтейнер
  double filterHeight = 0.0;

  //ф-я фильтер. Возвращает список с воркаутами
  List<Workout> filter() {
    //с перерисовкой
    setState(() {
      //в общий текст условие (если толькоМоиВоркауты истина
      //то в перем записать Май Воркаутс, иначе Алл воркаутс
      filterText = filterOnlyMyWorkouts ? 'My Workouts' : 'All workouts';
      //в перем. добавляем методом += черту " / " и перем. фильтерЛевел (выпадающий список)
      filterText += ' / ' + filterLevel;
      //если перем. для ручного ввода не пустая, добавить ее содержимое через черту " / "
      if(filterTitle.isNotEmpty) filterText += ' / ' + filterTitle;
      //высоту АнимейтедКонтейнера на нуль (свернуть)
      filterHeight = 0;
    });
    //в перем. лист кладем список воркаутс
    var list = workouts;
    //возвращаем эту перем. ?? зачем
    return list;
  }

  //ф-я чистит фильтры. Устанавливает значения на изначальные
  //и возвращает Список с классами Воркаут
  List<Workout> clearFilter() {
    //с перерисовкой
    setState(() {
      //общий текст сверху
      filterText = 'All workouts / Any Level';
      //переключатель ТолькоМоиВоркауты
      filterOnlyMyWorkouts = false;
      //переменная для хранения ручного ввода
      filterTitle = '';
      //для хранения выбора из выпадающего списка
      filterLevel = 'Any Level';
      //через контроллер - чистим
      filterTitleController.clear();
      //высота АнимайтедКонтейнера в нуль (свернуть)
      filterHeight = 0;
    });
    //в переменную лист помещаем Список воркаутс
    var list = workouts;
    //возвращаем этот список ?? зачем
    return list;
  }

  //все содержимое экрана
  @override
  Widget build(BuildContext context) {

    //обязательно экспандед, чтоы не было ошибок NEEDS-PAINT
    var workoutsList = Expanded(
      child: ListView.builder(
        //кол-во элементов. совпадает с кол-вом в массиве
        itemCount: workouts.length,
        //в билдер передаем контекст и индекс
        itemBuilder: (context, i){
          //возвращаем видет карточка
          return Card(
            color: Colors.white.withOpacity(0.0),
            //положение по оси Z. что-то типа z-index из CSS
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.5)
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
                  workouts[i].title!,
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
      ),
    );

    //полоска, при клике на которую раскрывается АнимейтедКонтейнер
    Widget filterInfo = Container(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white70,
      ),
      height: 40,
      child: TextButton(
        onPressed: (){
          //с перерисовкой
          setState(() {
            //условия с переменой высоты у АнимейтедКонтейнера
            filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
            //условие со сменой вида иконки у контейнера фильтерИнфо (текущ)
            filterIcon = (filterIcon==Icons.keyboard_arrow_down ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down);
          });
        },
        child: Row(
          children: [
            Icon(
              //иконка со стрелочкой, изменяемая при тапе выше
              filterIcon,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              //общий текст, ктр формируется выше в ф-ях фильтер() и клеарФильтер()
              filterText,
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
              //обрезка текста, если вылезет за пределы
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    //Страшная конструкция для выпадающего списка
    //есть переменная Список, со строковыми значениями
    var levelMenuItems = [
      'Any Level',
      'Beginner',
      'Intermediate',
      'Advanced'
      //этот список мы мапим
      //метод map - ф-я, ктр обрабатывает каждый элемент списка (что то типа цикла forEach)
      //на выходе получается новый список с измененными элементами списка
      //в ф-ю будет передаваться каждый элемент. Поэтому тип Стринг, тк в списке строки
    ].map((String value) {
      //возвращает элемент ДропдаунМенюАйтем для ДропдаунБаттонФромФилд (ниже)
      return DropdownMenuItem(
        //в значение вставляется строковый элемент из списка
        value: value,
        child: Text(
          //и в текст та же строка
          value,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      );
      //тоЛист - сконвертировать в Список
    }).toList();

    //анимированный контейнер, ктр не резко меняет свои параметры, а с анимацией
    var filterForm = AnimatedContainer(
      //то, что будем менять с анимацией
      height: filterHeight,
      margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 7),
      //длительность анимации
      duration: const Duration(milliseconds: 300),
      //кривая по которой следует анимация
      curve: Curves.fastOutSlowIn,
      //в контейнере Карточка в СингЧайлдСкроллВью, чтобы при свертывании не
      //ругалось на выход за рамки
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //в ней столбец
            child: Column(
              children: [
                //переключатель с подписью
                SwitchListTile(
                  activeColor: Theme.of(context).primaryColor,
                  title: Text(
                    'Only My Workouts',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  value: filterOnlyMyWorkouts,
                  //при клике меняет свое значение value с перерисовкой
                  onChanged: (bool val) {
                    setState(() {
                      filterOnlyMyWorkouts = val;
                    });
                  }
                ),
                //выпадающий список
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Level'),
                  //элементы списка выпадающего, сделаны страшной конструкцией выше
                  items: levelMenuItems,
                  //переменная со значением выбранным
                  value: filterLevel,
                  //при смене с перерисовкой записывать значение
                  onChanged: (String? val) {
                    setState(() {
                      filterLevel = val!;
                    });
                  },
                ),
                //текстовое поле
                TextFormField(
                  //к нему подключаем контроллер для простоты очистки и тд
                  controller: filterTitleController,
                  decoration: const InputDecoration(labelText: 'Title',),
                  //при изменении записать это изменени в переменную
                  onChanged: (val) {
                    setState(() {
                      filterTitle = val;
                    });
                  },
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                //строка с кнопками
                Row(
                  children: [
                    //экспандед с флексами 1, чтобы обе кнопки заняли все одинаковое пространство
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor
                          )
                        ),
                        //применить фильтр по логике из ф-ии фильтер()
                        onPressed: (){
                          filter();
                        },
                        child: const Text('Apply',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    //отступ между кнопками
                    const SizedBox(width: 10,),
                    //второй экспандед тоже с флексом 1
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.redAccent
                          )
                        ),
                        //при нажатии чистит фильтры
                        onPressed: clearFilter,
                        child: const Text('Clear',style: TextStyle(color: Colors.white),),
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    //ОСНОВНОЕ СОДЕРЖИМОЕ
    return Column(
      children: [
        //полоска для разворачивания анимированного контейнера
        filterInfo,
        //анимированный контейнер
        filterForm,
        //ЛистВью с воркаутами
        workoutsList,
      ],
    );
  }
}