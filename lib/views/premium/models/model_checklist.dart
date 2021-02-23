class Checklist {

  /// 이름.
  String name  ;

  /// 내용.
  String contents;

  String checklistId;

  String workoutId;

  ///
  bool isEditable = false;

  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'contents' : contents,
        'checklistId' : checklistId,
        'workoutId' : workoutId,
        'isEditable' : isEditable,
      };

  Checklist(this.name, this.contents, this.checklistId, this.workoutId, this.isEditable);
}