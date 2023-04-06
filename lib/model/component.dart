import 'package:flutter/material.dart';

class Component{//Component
  int? id;
  String? name;
  int? minute;
  TextEditingController? controllerName;
  TextEditingController? controllerMin;

  Component({this.id, required this.name, required this.minute,
    required this.controllerName, required this.controllerMin});
  Component.controller( this.controllerName, this.controllerMin );
  Component.empty();

  @override
  String toString() {
    return 'Component{name: $name, minute: $minute}';
  }
}