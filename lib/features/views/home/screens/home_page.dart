
import 'package:flutter/material.dart';

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
              ClipRRect(
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
            ],
          )
        ],
      ),
    );
  }
}
