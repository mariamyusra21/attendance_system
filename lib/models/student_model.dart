class StudentModel {
  final String rollno;
  final String name;
  final bool isPresent;

  StudentModel(this.rollno, this.name, this.isPresent);

  Map<String, dynamic> toJson() =>
      {'rollno': rollno, 'name': name, 'isPresent': isPresent};
}
