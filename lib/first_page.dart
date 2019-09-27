import 'package:flutter/material.dart';

///This is my app's home page. It is the first page you see when the app launches.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Anxiety'),
      ),
      /*This is the widget that lets me put the picture bellow
      * and put the button on the top.*/
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(//Places an image in the background.
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home_page_background.JPG'),
                    fit: BoxFit.fill)),
          ),
          Positioned(// Places the raised button at the bottom left of the screen.
            bottom: 48.0,
            left: 70.0,
            width: 100.0,

            child: RaisedButton(// My purple bottom that takes me to the calendar.
              color: Colors.white,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    style: BorderStyle.solid,
                    width: 5.0,
                    color: Colors.purple
                ),
              ),
              child: Text('Calendar'),
              onPressed: () {// goes to next route.
                Navigator.of(context).pushNamed('/calendar_page');
              },
            ),
          ),
        ],
      ),
    );
  }
}
