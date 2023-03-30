class StepSeq{
  int? id;
  String? name;
  int? minute;
  int? position;//todo delete
  int? sequence;

  StepSeq({this.id, required this.name, required this.minute,
    required this.position, required this.sequence});
  StepSeq.empty();

}