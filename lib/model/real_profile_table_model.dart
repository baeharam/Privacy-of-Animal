
class RealProfileTableModel {
  String uid;
  String name;
  int age;
  String gender;
  String job;

  RealProfileTableModel.all({
    this.uid,
    this.name,
    this.age,
    this.gender,
    this.job
  });

  RealProfileTableModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.age = map['age'];
    this.gender = map['gender'];
    this.job = map['job'];
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['job'] = job;
    return map;
  }

}