import 'package:flutter/material.dart';
import 'package:vendingapp/Profile/presentation/profile.dart';
import 'package:vendingapp/dashbord/widgets/display_container.dart';
import 'package:vendingapp/dashbord/widgets/top_data_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

//Poup bool variable
bool _isPopupOpen = false;
//function to toglle the popup
Widget _togglePopUp(BuildContext context) {
  if (_isPopupOpen) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Option 1'),
            Text('Option 2'),
            Text('Option 3'),
          ],
        ));
  }
  return const SizedBox.shrink();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF5FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Profile()));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff176B87),
                          border: Border.all(
                              color: Colors.black.withOpacity(0.3), width: 2)),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/img/user.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Water usage',
                    style: TextStyle(
                        color: Color(0xff176B87),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 20,
                                color: Color(0xff176B87),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'View all',
                                style: TextStyle(
                                    color: Color(0xff176B87),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ];
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Color(0xff176B87),
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            const TopDataContainer(),
            const DisplayContainer(),
          ],
        ),
      ),
    );
  }
}
