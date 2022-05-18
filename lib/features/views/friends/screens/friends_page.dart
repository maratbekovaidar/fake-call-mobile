
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const TextField(
          decoration: InputDecoration(
              hintText: "Search Friends",
              suffixIcon: Icon(Icons.search)
          ),
        ),
      ),
      body: ListView(
        children: [
          Card(

            elevation: 6,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: ListTile(
              // onTap: () {
              //
              // },
              leading: CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                    Icons.person
                  ),
                  onPressed: () {
                  },
                ),
                backgroundColor: Colors.purple,
              ),
              title: const Text("Абылай"),
              subtitle: const Text("Айып"),
              trailing: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Add Friend"),
                      ),

                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Favourite"),
                      ),

                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text("Share Location"),
                      ),
                    ];
                  },
                  onSelected:(value){
                  }
              ),
            ),
          ),
          Card(
            elevation: 6,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: ListTile(
              // onTap: () {
              //
              // },
              leading: CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                      Icons.person
                  ),
                  onPressed: () {
                  },
                ),
                backgroundColor: Colors.purple,
              ),
              title: const Text("Aidar"),
              subtitle: const Text("Maratbekov"),
              trailing: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Add Friend"),
                      ),

                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Favourite"),
                      ),

                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text("Share Location"),
                      ),
                    ];
                  },
                  onSelected:(value){
                  }
              ),
            ),
          ),
          Card(
            elevation: 6,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: ListTile(
              // onTap: () {
              //
              // },
              leading: CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                      Icons.person
                  ),
                  onPressed: () {
                  },
                ),
                backgroundColor: Colors.purple,
              ),
              title: const Text("Эльмира"),
              subtitle: const Text("Группаш"),
              trailing: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Add Friend"),
                      ),

                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Favourite"),
                      ),

                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text("Share Location"),
                      ),
                    ];
                  },
                  onSelected:(value){
                  }
              ),
            ),
          ),
          Card(
            elevation: 6,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: ListTile(
              // onTap: () {
              //
              // },
              leading: CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                      Icons.person
                  ),
                  onPressed: () {
                  },
                ),
                backgroundColor: Colors.purple,
              ),
              title: const Text("Сабина"),
              subtitle: const Text("Жоламанова"),
              trailing: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Add Friend"),
                      ),

                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Favourite"),
                      ),

                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text("Share Location"),
                      ),
                    ];
                  },
                  onSelected:(value){
                  }
              ),
            ),
          ),

        ],
      ),
    );
  }
}
