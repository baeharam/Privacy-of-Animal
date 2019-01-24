
class RealProfileTableModel {
  String _uid;
  String _name;
  String _age;
  String _gender;
  String _job;

  RealProfileTableModel(
    this._uid,
    this._name,
    this._age,
    this._gender,
    this._job
  );

  String get uid => _uid;
  String get name => _name;
  String get age => _age;
  String get gender => _gender;
  String get job => _job;

  RealProfileTableModel.fromMap(Map<String, dynamic> map) {
    this._uid = map['uid'];
    this._name = map['name'];
    this._age = map['age'];
    this._gender = map['gender'];
    this._job = map['job'];
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['uid'] = _uid;
    map['name'] = _name;
    map['age'] = _age;
    map['gender'] = _gender;
    map['job'] = _job;
    return map;
  }

}