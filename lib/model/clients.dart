class Clients{

  late int _id;
  late String _name;
  late String _phone;
  late String _address;
  late String _state;

  Clients(this._id, this._name, this._phone, this._address, this._state);


  Map toJson(){

    return{
      "id": this._id,
      "name": this._name,
      "phone": this._phone,
      "address": this._address,
      "state": this._state
    };

  }




  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
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