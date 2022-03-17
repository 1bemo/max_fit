//просто класс воркоут с ключами и обязательным их заполнением при инициализации
class Workout {
  String title;
  String author;
  String description;
  String level;

  Workout({
    required this.title,
    required this.author,
    required this.description,
    required this.level
});
}