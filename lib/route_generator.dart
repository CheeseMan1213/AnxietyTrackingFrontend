import 'package:flutter/material.dart';
import './first_page.dart';
import './second_page.dart';
import './third_page.dart';
import './error_page.dart';

///This class is the router. It is analogous to ui-router in Angular.
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
            date: args,//Here I am passing the ags from the calender page to the anxiety entry page.
          ),
        );
        break;
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
