import 'package:focus/model/component.dart';

class Sequence {
  int? id;
  String name;
  List<Component> components;
  Map<int,int>? map;

  Sequence({this.id, required this.name, required this.components});

  @override
  String toString() {
    return 'Sequence{id: $id, name: $name, list: $components}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sequence &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          components == other.components &&
          map == other.map;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ components.hashCode ^ map.hashCode;
}