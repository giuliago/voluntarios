import 'package:intl/intl.dart';

class Cadastro{
  final String name;
  final String location;
  //final DateTime birthday;
  final String email;
  final String password;

  Cadastro(
    this.name,
    this.location,
    //this.birthday,
    this.email,
    this.password,
  );

  @override
  String toString() {
    return 'Cadastro{name: $name, location: $location, email: $email, password: $password}';
  }

}