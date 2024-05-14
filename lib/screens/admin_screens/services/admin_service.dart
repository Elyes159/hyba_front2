import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:http/http.dart' as http;

class AdminService {
  Future<List<BabysitterModel>> fetchDemandes() async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://192.168.1.14:3000/api/babysitters/demandes/acceptees"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      List result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<BabysitterModel> babysitters = [];
        for (var babysitterData in result) {
          BabysitterModel user = BabysitterModel.fromJson(babysitterData);
          babysitters.add(user);
        }
        return babysitters;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<String> accepetDemandes() async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://192.168.1.14:3000/api/babysitters/demandes/acceptees"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'error';
      }
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }

  Future<String> refuseDemandes() async {
    try {
      var response = await http.get(
        Uri.parse("http://192.168.1.14:3000/api/babysitters/demandes/"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'error';
      }
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }
}
