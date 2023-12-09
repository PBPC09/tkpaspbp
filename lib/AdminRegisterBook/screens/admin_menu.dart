import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_menu_card.dart';
// import 'package:inventory_app_mobile/screens/book_collections.dart'; // Gantilah dengan nama halaman "Book Collections" yang sesuai
// import 'package:inventory_app_mobile/screens/notifications.dart'; // Gantilah dengan nama halaman "Notification" yang sesuai
// import 'package:lembarpena/authentication/login_page.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final List<AdminMenuItem> pages = [
    AdminMenuItem("Book Collections", Icons.book, Colors.blue),
    AdminMenuItem("Notification", Icons.notifications, Colors.green),
    AdminMenuItem("Book Form", Icons.add_circle, Colors.indigo),
    AdminMenuItem("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Admin Dashboard',
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
                  'Welcome to LembarPena', // Text yang menandakan toko
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
                children: pages.map((AdminMenuItem item) {
                  // Iterasi untuk setiap item
                  return AdminMenuCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
