import 'package:flutter/material.dart';
import './first_page.dart';
import './second_page.dart';
import './third_page.dart';
import './error_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case '/calendar_page':
        return MaterialPageRoute(builder: (_) => CalendarPage());
        break;
      case '/anxiety_entry':
        return MaterialPageRoute(
          builder: (_) => AnxietyEntryPage(
            date: args,
          ),
        );
        break;
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
