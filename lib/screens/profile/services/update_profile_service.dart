import 'dart:convert';
import 'package:babysitter/screens/auth/models/parent_model.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class UptadeProfile {
  Map<String, dynamic>? user = GetStorage().read('parent');

  Future<String> updateAccount(
    String nom,
    String prenom,
    String email,
    String phone,
    String password,
    String nbEnfants,
  ) async {
    try {
      String id = user!['id'];
      final requestBodyJson = json.encode({
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "password": password,
        "phone": phone,
        "nombreDesEnfants": nbEnfants,
      });
      var response = await http.put(
        Uri.parse("http://192.168.1.17:3000/api/babysitters"),
        body: requestBodyJson,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${user!['token']}',
        },
      );
      var updateJson = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        ParentModel user = ParentModel(
          id: updateJson['_id'],
          nom: updateJson['nom'],
          prenom: updateJson['prenom'],
          email: updateJson['email'],
          phone: updateJson['phone'],
          password: updateJson['password'],
          nbEnfants: updateJson['nombreDesEnfants'],
        );
        GetStorage().write('parent', user.toJson());
        return 'succes';
      } else {
        return 'error';
      }
    } catch (e) {
      print(e.toString());
    }

    return '';
  }
}
