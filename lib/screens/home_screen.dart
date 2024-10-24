import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'schedule_screen.dart';
import '../repository/user_repository.dart';
import '../models/user.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final LocalUserRepository userRepository = LocalUserRepository();
  User? currentUser;


  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }


  void _loadUserInfo() async {
    User? user = await userRepository.getUserInfo();
    setState(() {
      currentUser = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Головна сторінка'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser != null) ...[
              Text(
                'Привіт, ${currentUser!.name} ${currentUser!.surname}!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text('Електронна пошта: ${currentUser!.email}'),
            ],
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen()),
                );
              },
              child: Text('Перейти до розкладу'),
            ),
          ],
        ),
      ),
    );
  }
}
