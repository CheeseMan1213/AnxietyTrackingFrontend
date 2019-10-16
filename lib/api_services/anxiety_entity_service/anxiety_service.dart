/***
 * This is the service class for making the CRUD calls for the text collection.
 * I could not get the GET method to work when it was in this file, so I put it in the main.dart file,
 * but the rest are here.
 */

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/anxiety.dart';
class AnxietyService {

  //Takes a first and last name along with the post url and creates a new name in the database.
  static Future postAnxiety(String url, String date, String anxEntry, String todayWas) async {
    Anxiety newAnxietyEntry = new Anxiety(date, anxEntry, todayWas);

    var response = await http.post(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Content-type": "application/json"},
        body: json.encode(newAnxietyEntry.toJson()));
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      print('Successful Post.');
      return 'Successful Post.';
    } else {
      print('Failed Post.');
      return 'Failed Post.';
    }
  }
  //Receives a object so the _id matches one already in the database, then changes the first
  //and last name and sends it off for the update.
  static Future putAnxiety(String url, Anxiety anxietyToUpdate) async {
    var response = await http.put(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Content-type": "application/json"},
        body: json.encode(anxietyToUpdate.toJson()));
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      print('Successful Update.');
      return 'Successful Update.';
    } else {
      print('Failed Update.');
      return 'Failed Update.';
    }
  }

  //I am using POST instead of DELETE here, because I want to be able to send a body
  //as part of performing my delete. This is because I want only one entry, even if they
  //have the same first name, to be deleted. I want to use mongoDB's "_id", but
  //I do not want to send it as part of the URL. And Flutter's http library does
  //not have a "body" as part of its delete method as of Flutter 1.9,
  //and package http: ^0.12.0+2

  //Takes a Url and a specific object to delete.
  static Future deleteAnxiety(String url, Anxiety anxietyToDelete) async {
    var response  = await http.post(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Content-type": "application/json"},
        body: json.encode(anxietyToDelete.toJson()));

    int statusCode = response.statusCode;

    if(statusCode == 200) {
      print('Successful delete.');
      return 'Successful delete.';
    } else {
      print('Failed delete');
      print(statusCode);
      return 'Failed delete';
    }
  }
}
