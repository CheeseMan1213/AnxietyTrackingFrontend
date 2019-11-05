///This is a very small class who's sole purpose is to be used with the scoped_model library
///to be monitored for when is items are updated.
///This particular one is meant to be used with the anxiety model.

import 'package:flutter/material.dart';

class AnxietyBabyClass {
  //Will contain the data frm the database.
  var data = [];
  //Sets the initial color to be the green gradient.
  int groupValue = 1;
  //The controller adds additional functionality and data retrieval to the TextFormField().
  final TextEditingController anxEntryController = TextEditingController();
  final TextEditingController readOnly = TextEditingController();
}