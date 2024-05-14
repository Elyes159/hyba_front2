import 'package:flutter/material.dart';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:get_storage/get_storage.dart';

class RendezVousBabySitter extends StatefulWidget {
  final String type;

  const RendezVousBabySitter({Key? key, required this.type}) : super(key: key);

  @override
  _RendezVousBabySitterState createState() => _RendezVousBabySitterState();
}

class _RendezVousBabySitterState extends State<RendezVousBabySitter> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? user = GetStorage().read(widget.type);

    final List<DataColumn> columns = [
      DataColumn(label: Text('Nom Parent')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Heure de début')),
      DataColumn(label: Text('Heure de fin')),
    ];
  

    final List<DataRow> rows = (user?['rendezVous'] as List<dynamic>? ?? [])
        .map<DataRow>((rendezVousItem) {
      return DataRow(
        cells: [
          DataCell(Text(rendezVousItem['nomParent'])),
          DataCell(Text(rendezVousItem['date'])),
          DataCell(Text(rendezVousItem['heure_debut'])),
          DataCell(Text(rendezVousItem['heure_fin'])),
        ],
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Rendez-vous du Baby-Sitter'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }
}
