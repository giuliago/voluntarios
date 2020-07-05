import 'package:http/http.dart' as http;
import 'package:voluntarios/UI/signUp.dart';

void criaUser() {
  var url = "http://127.0.0.1/api/criaUser.php";
  var response =
      http.post(url, body: {'nome': name, 'email': email, 'senha': password});
}
