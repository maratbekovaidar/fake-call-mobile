
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const route = "/profile";
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: ListView(
        children: [

          /// Avatar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset(
                  "assets/logo.png",
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

          /// Name and Surname
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [

              Text("Aidar", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(width: 10),
              Text("Maratbekov", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),)
            ],
          ),
          const SizedBox(height: 50),

          /// Email
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 30),

              Text("Email: ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black38
              ),),
              SizedBox(width: 10),
              Text("maratbekovaidar@gmail.com", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline
              ),)
            ],
          ),
          const SizedBox(height: 10),

          /// Phone
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 30),

              Text("Phone: ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black38
              ),),
              SizedBox(width: 10),
              Text("+7 (708) 889 3456", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline
              ),)
            ],
          ),
          const SizedBox(height: 10),

          /// Password
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 30),

              Text("Password: ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black38
              ),),
              SizedBox(width: 10),
              Text("Change password", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline
              ),)
            ],
          ),
          const SizedBox(height: 200),

          /// Logout
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Logout")),
              const SizedBox(width: 50)
            ],
          )

        ],
      ),
    );
  }
}
