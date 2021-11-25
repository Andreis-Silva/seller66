class Routes{

 late int _id;
 late String _name;
 late String? _date;

 Routes(this._id, this._name);

 Map toJson(){

   return {
     "id": this._id,
     "name": this._name,
   };
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