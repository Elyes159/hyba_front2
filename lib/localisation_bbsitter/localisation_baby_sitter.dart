import 'package:babysitter/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalisationBBsitter extends StatefulWidget {
  @override
  _LocalisationBBsitterState createState() => _LocalisationBBsitterState();
}

class _LocalisationBBsitterState extends State<LocalisationBBsitter> {
  Future<Object> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getPositionStream().listen((Position? position) {
      print("============");
      print(position!.latitude);
      print(position.longitude);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        child: Text("location bbsitter"),
      ),
    );
  }
}
