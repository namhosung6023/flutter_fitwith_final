import 'package:flutter/material.dart';

class Diet  {
  int value = 0;
  String name = '';
  DietDetail detail;
  List<DropdownMenuItem> dropdownList = [];
  bool isChecked = false;

  Diet(this.value, this.name, this.detail, this.dropdownList);
}

class DietDetail {
  int value = 0;
  String name = '';
  List<DropdownMenuItem> dropdownList = [];

  DietDetail(this.value, this.name, this.dropdownList);
}