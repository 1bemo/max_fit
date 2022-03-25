//просто класс воркоут с ключами и обязательным их заполнением при инициализации
class Workout {
  String? title;
  String? author;
  String? description;
  String? level;

  Workout({this.title, this.author, this.description, this.level});
}

class WorkoutSchedule{
  List? weeks;

  WorkoutSchedule({this.weeks});

  WorkoutSchedule copy() {
    var copiedWeeks = weeks!.map((w) => w.copy()).toList();
    return WorkoutSchedule(weeks: copiedWeeks);
  }
}

class WorkoutWeek{
  String? notes;
  List? days;

  WorkoutWeek({this.days, this.notes});

  WorkoutWeek copy(){
    var copiedDays = days!.map((w) => w.copy()).toList();

    return WorkoutWeek(days: copiedDays, notes: notes);
  }

  int get daysWithDrills => days != null ? days!.where((d) => d.isSet).length : 0;
}

class WorkoutWeekDay {
  String? notes;
  List? drillBlocks;

  bool get isSet => drillBlocks != null && drillBlocks!.isNotEmpty;
  int get notRestDrillBlocksCount => isSet ? drillBlocks!.where((b) => b is! WorkoutDrillsBlock).length : 0;

  WorkoutWeekDay({this.drillBlocks,this.notes});

  WorkoutWeekDay copy(){
    var copiedBlocks = drillBlocks!.map((w) => w.copy()).toList();
    return WorkoutWeekDay(drillBlocks: copiedBlocks, notes: notes);
  }
}

class WorkoutDrill {
  String? title;
  String? weight;
  int? sets;
  int? reps;

  WorkoutDrill({this.title, this.weight, this.sets, this.reps});

  WorkoutDrill copy() {
    return WorkoutDrill(title: title, weight: weight, sets: sets, reps: reps);
  }
}

enum WorkoutDrillType {
  single,
  multiset,
  amrap,
  forTime,
  emom,
  rest,
  //TABATA
}

abstract class WorkoutDrillsBlock {
  WorkoutDrillType? type;
  List? drills;

  WorkoutDrillsBlock({this.type, this.drills});

  void changeDrillsCount(int count) {
    var diff = count - drills!.length;

    if (diff == 0) return;

    if(diff > 0) {
      for(int i = 0; i<diff; i++) {
        drills!.add(WorkoutDrill());
      }
    } else {
      drills = drills!.sublist(0, drills!.length+diff);
    }
  }

  WorkoutDrillsBlock copy();

  List copyDrills() {
    return drills!.map((w) => w.copy()).toList();
  }
}

class WorkoutSingleDrillBlock extends WorkoutDrillsBlock {
  WorkoutSingleDrillBlock(WorkoutDrill drill)
      : super(type: WorkoutDrillType.single, drills: [drill]);

  @override
  WorkoutSingleDrillBlock copy() {
    return WorkoutSingleDrillBlock(copyDrills()[0]);
  }
}

class WorkoutMultisetDrillBlock extends WorkoutDrillsBlock {
  WorkoutMultisetDrillBlock(List? drill)
      : super(type: WorkoutDrillType.multiset, drills: drill);

  @override
  WorkoutMultisetDrillBlock copy() {
    return WorkoutMultisetDrillBlock(copyDrills());
  }
}

class WorkoutAmrapDrillBlock extends WorkoutDrillsBlock {
  int? minutes;

  WorkoutAmrapDrillBlock({this.minutes, required List? drills})
      : super(type: WorkoutDrillType.amrap, drills: drills);

  @override
  WorkoutAmrapDrillBlock copy() {
    return WorkoutAmrapDrillBlock(minutes: minutes, drills: copyDrills());
  }
}

class WorkoutForTimeDrillBlock extends WorkoutDrillsBlock {
  int? timeCapMin;
  int? rounds;
  int? restBetweenRoundsMin;

  WorkoutForTimeDrillBlock({this.timeCapMin,this.rounds,this.restBetweenRoundsMin,required List? drills})
      : super(type: WorkoutDrillType.forTime, drills: drills);

  @override
  WorkoutForTimeDrillBlock copy() {
    return WorkoutForTimeDrillBlock(timeCapMin: timeCapMin, rounds: rounds,restBetweenRoundsMin: restBetweenRoundsMin, drills: copyDrills());
  }
}

class WorkoutEmomDrillBlock extends WorkoutDrillsBlock {
  int? timeCapMin;
  int? intervalMin;

  WorkoutEmomDrillBlock({this.timeCapMin,this.intervalMin,required List? drills})
      : super(type: WorkoutDrillType.emom, drills: drills);

  @override
  WorkoutEmomDrillBlock copy() {
    return WorkoutEmomDrillBlock(timeCapMin: timeCapMin, intervalMin: intervalMin,drills: copyDrills());
  }
}

class WorkoutRestrDrillBlock extends WorkoutDrillsBlock {
  int? timeMin;

  WorkoutRestrDrillBlock({this.timeMin})
      : super(type: WorkoutDrillType.rest, drills:[]);

  @override
  WorkoutRestrDrillBlock copy() {
    return WorkoutRestrDrillBlock(timeMin: timeMin);
  }
}