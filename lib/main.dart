import 'package:flutter/material.dart';
import './route_generator.dart';

///This is the main entry point of the whole app.
void main() => runApp(MyApp());

///This is the first class that gets ran from the app entry point.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//removes the debug banner.
      title: 'James\s Anxiety tracking app.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
