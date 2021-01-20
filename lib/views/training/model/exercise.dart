import 'package:flutter/material.dart';

class Exercise {
  int value = 0;
  String name = '';
  ExerciseDetail detail;
  List<DropdownMenuItem> dropdownList = [];
  bool isChecked = false;

  Exercise(this.value, this.name, this.detail, this.dropdownList);
}

class ExerciseDetail {
  int value = 0;
  String name = '';
  List<DropdownMenuItem> dropdownList = [];

  ExerciseDetail(this.value, this.name, this.dropdownList);
}