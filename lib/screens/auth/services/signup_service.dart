import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpService {
  Future<String> signUpBabySitter(
    String nom,
    String prenom,
    String email,
    String password,
    String phone,
    String description,
  ) async {
    try {
      final requestBodyJson = json.encode({
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "password": password,
        "phone": phone,
        "description": description,
        "accepte": "en attente"
      });
      print(requestBodyJson);
      var response = await http.post(
        Uri.parse('http://192.168.1.17:3000/api/babysitters/signup'),
        body: requestBodyJson,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      var signupJson = json.decode(response.body.toString());
      if (response.statusCode == 201) {
        return 'success';
      } else {
        return signupJson['message'];
      }
    } catch (e) {
      print(e.toString());
    }

    return '';
  }

  Future<String> signUpParent(
    String nom,
    String prenom,
    String email,
    String password,
    String phone,
    String nbEnfants,
  ) async {
    try {
      final requestBodyJson = json.encode({
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "password": password,
        "phone": phone,
        "nombreDesEnfants":
            nbEnfants.toString(), // Convertir nbEnfants en chaîne de caractères
      });
      print(requestBodyJson);
      var response = await http.post(
        Uri.parse('http://192.168.1.17:3000/api/parents/signup'),
        body: requestBodyJson,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      var signupJson = json.decode(response.body.toString());
      if (response.statusCode == 201) {
        return 'success';
      } else {
        return signupJson['message'];
      }
    } catch (e) {
      print(e.toString());
    }

    return '';
  }
}
