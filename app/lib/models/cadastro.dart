import 'package:intl/intl.dart';

class Cadastro {
  final String name;
  final String location;
  //final DateTime birthday;
  final String email;
  final String password;
  final DateTime date;

  Cadastro(
    this.name,
    this.location,
    //this.birthday,
    this.email,
    this.password,
    this.date,
  );

  @override
  String toString() {
    return 'Cadastro{name: $name, location: $location, email: $email, password: $password, date: $date}';
  }
}
