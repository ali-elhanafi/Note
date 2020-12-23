class Note {
  int _id;
  String _name;
  String _content;
  int _hours;
  int _newField;
  // opject constractor = perfared in sqflite
  Note(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _content = obj['content'];
    _hours = obj['hours'];
    _newField = obj['newField'];
  }
  // named constractor
  Note.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _content = data['content'];
    _hours = data['hours'];
    _newField = data['newField'];
  }
  // insert vaules to map
  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'content': _content,
        'hours': _hours,
        'newField': _newField
      };
  // cabsule allways prefared
  int get id => _id;
  String get name => _name;
  String get content => _content;
  int get hours => _hours;
  int get newField => _newField;
}
