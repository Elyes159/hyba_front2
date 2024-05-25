import 'dart:convert';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:http/http.dart' as http;

class RendezVous {
  final String nomParent;
  final DateTime date;
  final String heureDebut;
  final String heureFin;

  RendezVous({
    required this.nomParent,
    required this.date,
    required this.heureDebut,
    required this.heureFin,
  });

  factory RendezVous.fromJson(Map<String, dynamic> json) {
    return RendezVous(
      nomParent: json['nomParent'] ?? '',
      date: DateTime.parse(json['date'] ?? ''),
      heureDebut: json['heure_debut'] ?? '',
      heureFin: json['heure_fin'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "nomParent": nomParent,
        "date": date.toIso8601String(),
        "heure_debut": heureDebut,
        "heure_fin": heureFin,
      };
}

class BabysitterModel {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String phone;
  final String description;
  final String accepte;
  final List<RendezVous> rendezVous;
  final String fcmToken;

  BabysitterModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.phone,
    required this.description,
    required this.accepte,
    required this.rendezVous,
    required this.fcmToken,
  });

  factory BabysitterModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> rendezVousJson = json['rendezVous'] ?? [];
    List<RendezVous> rendezVousList =
        rendezVousJson.map((rv) => RendezVous.fromJson(rv)).toList();

    return BabysitterModel(
      id: json['_id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      accepte: json['accepte'] ?? '',
      fcmToken: json['fcmToken'] ?? "",
      rendezVous: rendezVousList,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "password": password,
        "phone": phone,
        "description": description,
        "accepte": accepte,
        "fcmToken": fcmToken,
        "rendezVous": rendezVous.map((rv) => rv.toJson()).toList(),
      };
}
