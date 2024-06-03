import 'package:flutter/material.dart';
import 'package:timetracker/screens/loginpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white),
            onPressed: () {},
          ),
          backgroundColor: Colors.blueGrey,
          title: const Text('Profile Page',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              profilecard(),
                const Divider(
                thickness: 0.5,
              ),
              infomethod(context),
            ],
          ),
        ));
  }

  Column profilecard() {
    return Column(children: [
      const SizedBox(height: 20),
      const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('images/person.png'),
      ),
      const SizedBox(height: 20),
      const Text("Anna",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Text("anna@gmail.com",
          style: TextStyle(
            fontSize: 18,
          )),
      Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
            onPressed: () {},
            child: const Text('Edit Profile',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      ),
      const SizedBox(height: 20),
    ]);
  }

  Container infomethod(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Infocard(title: 'My Profile', icon: Icons.person),
              const Divider(
                thickness: 0.5,
              ),
              const Infocard(title: 'Notifications', icon: Icons.notifications),
              const Divider(
                thickness: 0.5,
              ),
              const Infocard(title: 'Settings', icon: Icons.settings),
              const Divider(
                thickness: 0.5,
              ),
              const Infocard(title: 'Community', icon: Icons.people),
              const Divider(
                thickness: 0.5,
              ),
              const Infocard(title: 'Services', icon: Icons.design_services),
              const Divider(
                thickness: 0.5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Infocard(
                      title: 'Logout', icon: Icons.logout_outlined)),
            ],
          ),
        ));
  }
}

class Infocard extends StatelessWidget {
  const Infocard({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
            size: 25,
          ),
          const SizedBox(width: 20),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, )),
        ],
      ),
    );
  }
}
