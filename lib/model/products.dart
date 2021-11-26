class Products {
  late int _id;
  late String _name;
  late int _active;
  late String _value;

  Products(this._id, this._name, this._active, this._value);

  Map toJson() {
    return {
      "id": this._id,
      "name": this._name,
      "active": this._active,
      "value": this._value,
    };
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  int get active => _active;

  set active(int value) {
    _active = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
