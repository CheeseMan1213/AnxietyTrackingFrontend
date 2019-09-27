import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

///This is the page that displays the calender.
///It is a stateful widget.
///This file depends on the 3rd party package table_calendar.dart.
///downloaded by this project's pubspec.yaml file
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarStyle: CalendarStyle(
              todayColor: Theme.of(context).primaryColorDark,
              selectedColor: Theme.of(context).primaryColor,
            ),
            calendarController: _controller,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (date, events) {
              //print('You are so cool!');
              Navigator.of(context).pushNamed(
                '/anxiety_entry',
                arguments: date,
              );
            },
          ),
          Text('Calendar'),
        ],
      ),
    );
  }
}
