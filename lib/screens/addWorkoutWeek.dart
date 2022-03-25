import 'package:flutter/material.dart';
import 'package:max_fit/components/common/saveButton.dart';
import 'package:max_fit/core/constants.dart';
import 'package:max_fit/domain/workout.dart';
import 'package:max_fit/screens/addWorkoutDay.dart';

class AddWorkoutWeek extends StatefulWidget {
  const AddWorkoutWeek({Key? key, this.week}) : super(key: key);
  final WorkoutWeek? week;

  @override
  _AddWorkoutWeekState createState() => _AddWorkoutWeekState();
}

class _AddWorkoutWeekState extends State<AddWorkoutWeek> {
  WorkoutWeek week = WorkoutWeek();

  @override
  void initState() {
    if (widget.week != null && widget.week!.days!.length == 7) {
      week = widget.week!.copy();
    } else {
      week.days = [
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: [])
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaxFit // Create Week Plan'),
        actions: <Widget>[
          SaveButton(
            onPressed: () {
              Navigator.of(context).pop(week);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: bgColorWhite),
        child: ListView.builder(
            itemCount: week.days!.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: InkWell(
                  onTap: () async {
                    var day = week.days![i];
                    var newDay = await Navigator.push<WorkoutWeekDay>(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddWorkoutDay(day: day)));
                    if (newDay != null) {
                      setState((){
                        week.days![i] = newDay;
                      });
                    }
                  },
                  child: Container(
                    decoration:
                    const BoxDecoration(color: Color.fromRGBO(50, 65, 85, 0.9)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12),
                        child: week.days![i].isSet
                            ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                            : const Icon(
                          Icons.hourglass_empty,
                          color: Colors.blue,
                        ),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1, color: Colors.white24))),
                      ),
                      title: Text(
                          'Day ${i + 1} - ' +
                              (week.days![i].isSet
                                  ? '${week.days![i].notRestDrillBlocksCount} drills'
                                  : 'Rest Day'),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
