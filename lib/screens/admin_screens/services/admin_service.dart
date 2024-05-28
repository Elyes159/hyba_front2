import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:http/http.dart' as http;

class AdminService {
  Future<List<BabysitterModel>> fetchDemandes() async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://192.168.1.17:3000/api/babysitters/demandes/en-attente"),
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
            "http://192.168.1.17:3000/api/babysitters/demandes/acceptees"),
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
        Uri.parse("http://192.168.1.17:3000/api/babysitters/demandes/refusees"),
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

  Future<List<Map<String, dynamic>>> getNotifications() async {
    var uri = Uri.parse('http://192.168.1.17:3000/api/admin/getNotif');
    var response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> notifications = jsonDecode(response.body);
      return notifications
          .map((notification) => notification as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
