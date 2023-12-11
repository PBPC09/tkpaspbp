import 'package:flutter/material.dart';
import 'package:lembarpena/Authentication/login_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/Main/widgets/lembarpena_card.dart';

class MenuItem {
  final String name;
  final IconData icon;
  final Color color;

  MenuItem(this.name, this.icon, this.color);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<MenuItem> pages = [
    MenuItem("Buy Books", Icons.shopping_bag, Colors.indigo),
    MenuItem("Wishlist", Icons.favorite, Colors.indigo),
    MenuItem("Explore Book", Icons.search, Colors.indigo),
    MenuItem("Cart", Icons.add_shopping_cart, Colors.indigo),
    MenuItem("Book Forum", Icons.chat, Colors.indigo),
    MenuItem("My Order", Icons.receipt, Colors.indigo),
    MenuItem("Admin Page", Icons.admin_panel_settings, Colors.indigo),
    MenuItem("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    String uname = LoginPage.uname;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi - $uname !',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Welcome to Lembar Pena', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: pages.map((MenuItem item) {
                  // Iterasi untuk setiap item
                  return MenuCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
