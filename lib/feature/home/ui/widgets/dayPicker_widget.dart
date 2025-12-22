import 'package:flutter/material.dart';

class DayPickerWidget extends StatelessWidget {
  final DateTime currentDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DayPickerWidget({
    super.key,
    required this.currentDate,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    String currentDay;
    if (selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day) {
      currentDay = 'Today';
    } else {
      currentDay = days[selectedDate.weekday - 1];
    }


    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime date = currentDate.add(
                    Duration(days: index - currentDate.weekday + 1),
                  );
                  String dayName = days[date.weekday - 1];
                  bool isSelected =
                      date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;

                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: Color(0xffEEE9FF),
                    leading: Icon(
                      Icons.calendar_today,
                      color: isSelected ? Color(0xff5F33E1) : Colors.grey,
                    ),
                    title: Text(
                      date.year == currentDate.year &&
                      date.month == currentDate.month &&
                      date.day == currentDate.day
                          ? 'Today'
                          : dayName,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Color(0xff5F33E1) : Colors.black,
                      ),
                    ),
                    subtitle: Text('${date.day}/${date.month}/${date.year}'),
                    onTap: () {
                      onDateSelected(date);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentDay),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
