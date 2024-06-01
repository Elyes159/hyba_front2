import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:babysitter/screens/home_screen/service/home_service.dart';
import 'package:babysitter/screens/profile/profile_screen.dart';
import 'package:babysitter/calendarForBabysitter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String?> _profilePicBase64List = [];

  @override
  void initState() {
    super.initState();
    _loadProfilePics();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8CDF9),
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
                          const Text(
                            'Hi',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '17 April, 2024',
                            style: TextStyle(
                              color: Colors.grey[200],
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (e) => const ProfileScreen(
                              type: 'parent',
                            ),
                          ),
                        ),
                        child: const Icon(Icons.person),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.black),
                        SizedBox(width: 7),
                        Text('Search'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Size of the space
            Expanded(
              child: ClipRRect(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  color: Colors.grey[100],
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Liste des offres',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Voir les offres'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Expanded(
                          child: FutureBuilder<List<BabysitterModel>>(
                            future: HomeService().fetchBabySitters(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No BabySitter',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        final babysitterName =
                                            snapshot.data![index].id;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CalendrierRendezVousPage(
                                              babysitterName: babysitterName,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          children: [
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
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${snapshot.data![index].nom} ${snapshot.data![index].prenom}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].phone,
                                                  style: const TextStyle(
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
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ],
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
