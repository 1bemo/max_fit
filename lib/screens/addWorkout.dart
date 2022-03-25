import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:max_fit/components/common/saveButton.dart';
import 'package:max_fit/components/common/toast.dart';
import 'package:max_fit/core/constants.dart';
import 'package:max_fit/domain/workout.dart';
import 'package:max_fit/screens/addWorkoutWeek.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({Key? key, this.workoutSchedule}) : super(key: key);

  final WorkoutSchedule? workoutSchedule;

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {

  final _fbKey = GlobalKey<FormBuilderState>();

  WorkoutSchedule workout = WorkoutSchedule(weeks: []);

  @override
  void initState() {
    if(widget.workoutSchedule != null) workout = widget.workoutSchedule!.copy();
    super.initState();
  }

  void _saveWorkout() {
    if (_fbKey.currentState!.saveAndValidate()) {
      if(workout.weeks == null || workout.weeks!.isEmpty) {
        buildToast('Please add at least one training week');
        return;
      }

      Navigator.of(context).pop(workout);
    } else {
      buildToast('Ooops! Something is not right');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaxFit // Create'),
        actions: [
          SaveButton(onPressed: _saveWorkout()),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: bgColorWhite),
        child: Column(
          children: [
            FormBuilder(
              key: _fbKey,
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: const {},
              child: Column(
                children: [
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Title'
                    ),
                    name: 'title',
                    onChanged: (val) {},
                    //------------------------------validators: []
                  ),
                  FormBuilderDropdown(
                      name: 'level',
                      decoration: const InputDecoration(
                        labelText: 'Level*'
                      ),
                      initialValue: 'Beginner',
                      allowClear: false,
                      hint: const Text('Select Level'),
                      items: ['Beginner','Intermediate','Advanced']
                          .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level.toString()),
                      )).toList(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weeks',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),

                IconButton(
                    onPressed: () async {
                      var week = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => AddWorkoutWeek()));

                      if (week != null) {
                        setState(() {
                          workout.weeks!.add(week);
                        });
                      }
                    },
                    icon: const Icon(Icons.add),
                )
              ],
            ),
            workout.weeks!.isEmpty
                ? const Text(
                    'Please add at least one training week',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                : _buildWeeks()
          ],
        ),
      ),
    );
  }

  Widget _buildWeeks() {
    return Expanded(
      //padding: EdgeInsets.all(5),
        child: Column(
            children: workout.weeks!
                .map((week) => Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: InkWell(
                onTap: () async {
                  var ind = workout.weeks!.indexOf(week);

                  var modifiedWeek = await Navigator.push<WorkoutWeek>(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              AddWorkoutWeek(week: week)));
                  if (modifiedWeek != null) {
                    setState(() {
                      workout.weeks[ind] = modifiedWeek;
                    });
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(50, 65, 85, 0.9)),
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      padding: const EdgeInsets.only(right: 12),
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1, color: Colors.white24))),
                    ),
                    title: Text(
                        'Week ${workout.weeks!.indexOf(week) + 1} - ${week.daysWithDrills} Training Days',
                        style: TextStyle(
                            color:
                            Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ))
                .toList()));
  }

}

