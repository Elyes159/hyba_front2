import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<BabysitterModel>> fetchBabySitters() async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://192.168.1.17:3000/api/babysitters/demandes/acceptees"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      List result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<BabysitterModel> babysitters = [];
        for (var babysitterData in result) {
          List<RendezVous> rendezVousList = [];
          // Suppose que babysitterData['rendezVous'] est une liste d'objets rendez-vous
          for (var rendezVousData in babysitterData['rendezVous']) {
            RendezVous rendezVous = RendezVous.fromJson(rendezVousData);
            rendezVousList.add(rendezVous);
          }

          BabysitterModel user = BabysitterModel(
            id: babysitterData['_id'] ?? '',
            nom: babysitterData['nom'] ?? '',
            prenom: babysitterData['prenom'] ?? '',
            email: babysitterData['email'] ?? '',
            password: babysitterData['password'] ?? '',
            phone: babysitterData['phone'] ?? '',
            description: babysitterData['description'] ?? '',
            accepte: babysitterData['accepte'] ?? '',
            rendezVous: rendezVousList,
          );
          babysitters.add(user);
        }

        return babysitters;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return []; // Ajout de la clause return pour gérer les erreurs et renvoyer une liste vide
    }
  }
}
