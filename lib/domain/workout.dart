//просто класс воркоут с ключами и обязательным их заполнением при инициализации
class Workout {
  String title;
  String author;
  String description;
  String level;

  Workout({required this.title, required this.author, required this.description, required this.level});
}

// class WorkoutSchedule{
//   List<WorkoutWeek> weeks;
//
//   WorkoutSchedule copy() {
//     var copiedWeeks = weeks.map((w) => w.copy()).toList();
//   }
// }
//
// class WorkoutWeek{
//   String notes;
//   List<WorkoutWeekDay> days;
//
//   WorkoutWeek({required this.days, required this.notes});
//
//   WorkoutWeek copy(){
//     var copiedDays = days.map((w) => w.copy()).toList();
//   }
// }