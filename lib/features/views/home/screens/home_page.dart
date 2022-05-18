
import 'package:fake_call_mobile/features/views/call/screens/add_voice.dart';
import 'package:fake_call_mobile/features/views/home/screens/voices_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchBar = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const TextField(
          decoration: InputDecoration(
            hintText: "Search voice caller",
            suffixIcon: Icon(Icons.search)
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              /// Category
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VoicesPage()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: width / 2 - 20,
                    child: Column(
                      children: [
                        Image.asset('assets/categories/taxi.jpg'),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Taxi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    color: Colors.white,
                  ),
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width / 2 - 20,
                  child: Column(
                    children: [
                      Image.asset('assets/categories/other.jpg'),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Others",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              /// Category
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width / 2 - 20,
                  child: Column(
                    children: [
                      Image.asset('assets/categories/parents.jpg'),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Parents",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width / 2 - 20,
                  child: Column(
                    children: [
                      Image.asset('assets/categories/other.jpg'),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Others",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ]
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)  => const AddVoicePage()));
        },
        child: const Icon(
          Icons.add_ic_call
        ),
      ),
    );
  }
}
