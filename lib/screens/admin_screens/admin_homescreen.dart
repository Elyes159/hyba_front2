import 'dart:convert';

import 'package:babysitter/screens/admin_screens/admin_offre_details.dart';
import 'package:babysitter/screens/admin_screens/services/admin_service.dart';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:babysitter/screens/home_screen/service/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<String?> _profilePicBase64List = [];

  Future<void> _loadProfilePics() async {
    final babySitters = await HomeService().fetchBabySitters();
    for (var babysitter in babySitters) {
      final response = await http.post(
        Uri.parse('http://192.168.1.17:3000/api/babysitters/getProfilePicById'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': babysitter.id}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _profilePicBase64List.add(data['profilePicData']);
        });
      } else {
        print(
            'Failed to load profile picture for babysitter ${babysitter.id}: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfilePics();
  }

  Icon _buildDeleteIcon(int index) {
    return Icon(Icons.delete);
  }

  Future<void> _deleteBabysitter(String id, int index) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.17:3000/api/babysitters/Delete/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _profilePicBase64List.removeAt(index);
      });
      print('Babysitter deleted successfully.');
    } else {
      print('Failed to delete babysitter: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8CDF9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ADMIN DASHBOARD !',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '17 april,2024',
                            style: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.bell,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  // search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20, // Taille de l'espace
            ),
            Expanded(
              child: ClipRRect(
                child: Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.grey[100],
                  child: SingleChildScrollView(
                    child: Center(
                      //child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Baby-sitters requests :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          FutureBuilder<List<BabysitterModel>>(
                            future: AdminService().fetchDemandes(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No BabySitter',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                AdminOffreDetailsPage(
                                                  user: snapshot.data![index],
                                                )),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          children: [
                                            // Icône poubelle
                                            GestureDetector(
                                              onTap: () {
                                                _deleteBabysitter(
                                                    snapshot.data![index].id,
                                                    index);
                                              },
                                              child: _buildDeleteIcon(index),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              child: CircleAvatar(
                                                backgroundImage: _profilePicBase64List
                                                            .isNotEmpty &&
                                                        _profilePicBase64List[
                                                                index] !=
                                                            null
                                                    ? MemoryImage(base64Decode(
                                                            _profilePicBase64List[
                                                                index]!))
                                                        as ImageProvider<
                                                            Object>?
                                                    : null,
                                                child: _profilePicBase64List
                                                            .isEmpty ||
                                                        _profilePicBase64List[
                                                                index] ==
                                                            null
                                                    ? const Icon(Icons.person)
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //title
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data![index].nom} ${snapshot.data![index].prenom}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //subtitle
                                                Text(
                                                  snapshot.data![index].phone,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
