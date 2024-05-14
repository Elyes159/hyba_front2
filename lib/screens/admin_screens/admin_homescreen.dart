import 'package:babysitter/screens/admin_screens/admin_offre_details.dart';
import 'package:babysitter/screens/admin_screens/services/admin_service.dart';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
                          )
                        ],
                      ),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          CupertinoIcons.bell,
                        ),
                        onPressed: () {
                          // Add the desired functionality for the notification bell here, e.g., open notifications view
                          //print("Notifications icon tapped!");
                        },
                      )),
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
                                    fontWeight: FontWeight.bold, fontSize: 22),
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
                                          // Ajoutez ici l'action à exécuter lors du tap
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
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/images/Profile_Image.png'),
                                                  backgroundColor: Colors.white,
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
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
