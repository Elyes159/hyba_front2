import 'package:babysitter/screens/admin_screens/services/admin_service.dart';
import 'package:babysitter/screens/auth/models/babysitter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminOffreDetailsPage extends StatelessWidget {
  final BabysitterModel user;
  const AdminOffreDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8CDF9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Typically used to go back to the previous screen
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.bell,
                    ),
                    onPressed: () {
                      // Add the desired functionality for the notification bell here, e.g., open notifications view
                      print("Notifications icon tapped!");
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 5),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Profile_Image.png'),
                        radius: 30,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.nom} ${user.prenom}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                user.phone,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 3),
                      //   Container(
                      //   padding:
                      //    EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                      //  decoration: BoxDecoration(
                      //   color: Colors.grey[300],
                      //  borderRadius: BorderRadius.circular(8),
                      // ),
                      // child: Text(
                      // 'Experience: 5 years',
                      //  style: TextStyle(
                      //     fontSize: 14,
                      //    ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Détails',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await AdminService().accepetDemandes();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Set button color
                              minimumSize:
                                  const Size(150, 10), // Set button size
                            ),
                            child: const Text(
                              'Accept',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Add spacing between buttons
                          ElevatedButton(
                            onPressed: () async {
                              // Add your reject logic here
                              await AdminService().refuseDemandes();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Set button color
                              minimumSize:
                                  const Size(150, 10), // Set button size
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
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
