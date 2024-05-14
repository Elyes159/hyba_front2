import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8CDF9),
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
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Typically used to go back to the previous screen
                    },
                  ),
                  IconButton(
                    icon: Icon(
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
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Profile_Image.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rahma Ben Ahmed',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Sousse',
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
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'Prix par heure: 40dt',
                        style: TextStyle(
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
            SizedBox(height: 35),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
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
                      Text(
                        'Détails',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Offer description goes here...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add functionality here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xffFFA500), //orange color
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          MaterialButton(
                              onPressed: () {
                                // Add functionality here
                              },
                              color: Colors.grey[300],
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15),
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.chat_bubble,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('Icon button tapped!');
                                },
                              )),
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
