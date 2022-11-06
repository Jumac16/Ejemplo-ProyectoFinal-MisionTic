class User{
  late String _name;
  late String _email;
  late String _password;

  User(this._name, this._email, this._password);

  User.empty();

  User.fromJson(Map<String, dynamic> json):
      _name = json['name'],
      _email = json['email'],
      _password = json['password'];

  Map<String, dynamic> toJson() => {
    'name': _name,
    'email': _email,
    'password': _password,
   };

  get name => _name;

  set name(value){
    _name = value;
  }

  get email => _email;

  set email(value){
    _email = value;
  }

  get password => _password;

  set password(value){
    _password = value;
  }

}